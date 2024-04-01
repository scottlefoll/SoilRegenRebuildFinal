from django.views import View
import requests
import pandas as pd
from datetime import datetime, date, timedelta
from django.conf import settings
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import PasswordResetForm, UserCreationForm
from django.contrib.auth.views import PasswordResetView
from django.core.mail import send_mail
from django.core.serializers import serialize
from django.db import transaction, IntegrityError
from django.http.response import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.template import loader
from django.urls import reverse, reverse_lazy
from django.utils.decorators import method_decorator
from django.utils import dateformat, formats, timezone
from django.views.decorators.csrf import csrf_exempt
from django.views import View, generic
from django.views.generic import FormView
from .forms import CustomUserCreationForm

from .forms import AddFarmForm, DeleteFarmForm, RecipeForm
from .models import Country, Farm, Field, Recipe, UserProfile
from .services import  AmendmentRatioService


def index(request):
    return render(request, 'home.html')

# views for static pages

def home_view(request):
    """Render the home page."""
    print("Home view is being called")
    return render(request, 'home.html')

def about_view(request):
    """Render the about page."""
    print("About view is being called")
    return render(request, 'about.html')

def contact_view(request):
    """Render the contact page."""
    print("Contact view is being called")
    return render(request, 'contact.html')

def profile_view(request):
    """Render the profile page."""
    print("Profile view is being called")
    return render(request, 'profile.html')

def custom_logout(request):
    logout(request)
    print("User has logged out")
    return render(request, 'logged_out.html')


class FarmController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def farm_list(self, request):
        print("Farm: GET ALL")
        farms = Farm.objects.all()
        context = {'farms': sorted(farms, key=lambda farm: farm.farm_name)}
        return render(request, 'farm_list.html', context)

    def farm_detail(request, farm_id):
        try:
            farm = Farm.objects.get(farm_id=farm_id)
            farm_fields = farm.field_set.order_by('field_name')
        except Farm.DoesNotExist:
            messages.error(request, f"Farm ID {farm_id} does not exist")
            return redirect('farm_list')
        context = {
            'farm': farm,
            'farm_fields': farm_fields
        }
        return render(request, 'farm_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_farm(self, request):
        if request.method == 'POST':
            farm_name = request.POST.get('farm_name')
            description = request.POST.get('description')
            user_id = request.POST.get('user_id')
            new_farm = Farm.objects.create(
                farm_name=farm_name,
                description=description,
                user_id=user_id
            )
            new_farm.save()
            return redirect('farm_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_farm(self, request, farm_id):
        farm = get_object_or_404(Farm, farm_id=farm_id)
        if request.method == 'POST':
            farm.farm_name = request.POST.get('farm_name')
            farm.description = request.POST.get('description')
            farm.user_id = request.POST.get('user_id')
            farm.save()
            return redirect('farm_detail', farm_id=farm.farm_id)

    # Delete operation
    def delete_farm(self, request, farm_id):
        farm = get_object_or_404(Farm, farm_id=farm_id)
        farm.delete()
        return redirect('farm_list')


class FieldController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def field_list(self, request):
        print("Field: GET ALL")
        fields = Field.objects.all() 
        context = {'fields': sorted(fields, key=lambda field: field.field_name)}
        return render(request, 'field_list.html', context)

    def field_detail(request, field_id):
        try:
            field = Field.objects.get(field_id=field_id)
        except Field.DoesNotExist:
            messages.error(request, f"Field ID {field_id} does not exist")
            return redirect('field_list')
        context = {
            'field': field,
        }
        return render(request, 'field_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_field(self, request):
        if request.method == 'POST':
            field_name = request.POST.get('field_name')
            field_acres = request.POST.get('field_acres')
            soil_type = request.POST.get('soil_type')
            growing_zone = request.POST.get('growing_zone')
            description = request.POST.get('description')
            farm_id = request.POST.get('farm_id')
            new_field = Field.objects.create(
                field_name=field_name,
                field_acres=field_acres,
                soil_type=soil_type,
                growing_zone=growing_zone,
                description=description,
                farm_id=farm_id
            )
            new_field.save()
            return redirect('field_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_field(self, request, field_id):
        field = get_object_or_404(Field, field_id=field_id)
        if request.method == 'POST':
            field.field_name = request.POST.get('field_name')
            field.field_acres = request.POST.get('field_acres')
            field.soil_type = request.POST.get('soil_type')
            field.growing_zone = request.POST.get('growing_zone')
            field.description = request.POST.get('description')
            field.farm_id = request.POST.get('farm_id')
            field.save()
            return redirect('field_detail', field_id=field.field_id)

    # Delete operation
    def delete_field(self, request, field_id):
        field = get_object_or_404(Field, field_id=field_id)
        field.delete()
        return redirect('field_list')


class RecipeController(View):

    def get(self, request, *args, **kwargs):
        if 'recipe_id' in kwargs:
            return self.recipe_detail(request, kwargs['recipe_id'])
        else:
            return self.recipe_list(request)
        
    def recipe_list(self, request):
        # Fetch all recipes from the database and order them by name
        recipes = Recipe.objects.all().order_by('recipe_name')
        context = {'recipes': recipes}
        return render(request, 'recipe.html', context)
    
    def recipe_detail(self, request, recipe_id):
        recipe = get_object_or_404(Recipe, recipe_id=recipe_id)
        # check if the current user is the owner of the recipe
        # and pass that information to the template for conditional display of edit/delete options
        is_owner = False
        if request.user.is_authenticated and recipe.user == request.user.userprofile:
            is_owner = True
            
        context = {'recipe': recipe}
        return render(request, 'recipe_detail.html', context)

    @method_decorator(login_required(login_url='/accounts/login/'))
    def create_recipe(self, request):
        if request.method == 'POST':
            form = RecipeForm(request.POST)
            if form.is_valid():
                new_recipe = form.save(commit=False)
                new_recipe.user = UserProfile.objects.get(user=request.user)
                new_recipe.save()
                messages.success(request, 'Recipe added successfully!')
                return redirect('recipe_list')
            else:
                for error in form.errors:
                    messages.error(request, f"{error}: {form.errors[error]}")
        else:
            form = RecipeForm()
        return render(request, 'recipe_form.html', {'form': form})

    @method_decorator(login_required(login_url='/accounts/login/'))
    def update_recipe(self, request, recipe_id):
        recipe = get_object_or_404(Recipe, recipe_id=recipe_id)
        if request.method == 'POST':
            form = RecipeForm(request.POST, instance=recipe)
            if form.is_valid():
                form.save()
                messages.success(request, 'Recipe updated successfully!')
                return redirect('recipe_detail', recipe_id=recipe.recipe_id)
            else:
                for error in form.errors:
                    messages.error(request, f"{error}: {form.errors[error]}")
        else:
            form = RecipeForm(instance=recipe)
        return render(request, 'recipe_form.html', {'form': form, 'recipe': recipe})

    @method_decorator(login_required(login_url='/accounts/login/'))
    def delete_recipe(self, request, recipe_id):
        recipe = get_object_or_404(Recipe, recipe_id=recipe_id)
        recipe.delete()
        messages.success(request, 'Recipe deleted successfully!')
        return redirect('recipe_list')


class ResetView(PasswordResetView):
    form_class = PasswordResetForm
    template_name = "registration/password_reset.html"
    email_template_name = 'registration/password_reset_email.html'  # Optional: customize the email template
    success_url = reverse_lazy("password_reset_done")  # Specify the URL for the password reset done page

    def form_valid(self, form):
        print("Sending email")
        return super().form_valid(form)
    
    
class SignUpView(generic.CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy("login")
    template_name = "registration/signup.html"


class UserProfileController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def profile_list(self, request):
        print("UserProfile: GET ALL")
        user_profiles = UserProfile.objects.all()
        context = {'user_profiles': sorted(user_profiles, key=lambda profile: profile.user.username)}
        return render(request, 'user_profile_list.html', context)

    def profile_detail(self, request, user_id):
        try:
            user_profile = UserProfile.objects.get(user_id=user_id)
        except UserProfile.DoesNotExist:
            messages.error(request, f"User ID {user_id} does not exist")
            return redirect('profile_list')
        context = {
            'user_profile': user_profile
        }
        return render(request, 'user_profile_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_profile(self, request):
        if request.method == 'POST':
            user = request.POST.get('user')
            street_address = request.POST.get('street_address')
            town = request.POST.get('town')
            state = request.POST.get('state')
            zip = request.POST.get('zip')
            phone = request.POST.get('phone')
            notes = request.POST.get('notes')

            new_profile = UserProfile.objects.create(
                user=user,
                street_address=street_address,
                town=town,
                state=state,
                zip=zip,
                phone=phone,
                notes=notes,
            )
            new_profile.save()
            return redirect('profile_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_profile(self, request, user_id):
        user_profile = get_object_or_404(UserProfile, user_id=user_id)
        if request.method == 'POST':
            user_profile.street_address = request.POST.get('street_address')
            user_profile.town = request.POST.get('town')
            user_profile.state = request.POST.get('state')
            user_profile.zip = request.POST.get('zip')
            user_profile.phone = request.POST.get('phone')
            user_profile.notes = request.POST.get('notes')

            user_profile.save()
            return redirect('profile_detail', user_id=user_profile.user.id)

    # Delete operation
    def delete_profile(self, request, user_id):
        user_profile = get_object_or_404(UserProfile, user_id=user_id)
        user_profile.delete()
        return redirect('profile_list')
