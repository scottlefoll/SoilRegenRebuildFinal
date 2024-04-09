from django.views import View
import requests
import pandas as pd
import json
from datetime import datetime, date, timedelta
from django.conf import settings
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.forms import PasswordResetForm, UserCreationForm
from django.contrib.auth.views import PasswordResetView
from django.core.mail import send_mail
from django.core.serializers import serialize
from django.core import serializers
from django.core.serializers.json import DjangoJSONEncoder
from django.db import transaction, IntegrityError
from django.forms.models import model_to_dict
from django.http import JsonResponse
from django.http.response import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render, redirect
from django.template import loader
from django.urls import reverse, reverse_lazy
from django.utils.decorators import method_decorator
from django.utils import dateformat, formats, timezone
from django.views.decorators.csrf import csrf_exempt
from django.views import View, generic
from django.views.generic import FormView, ListView, DetailView, CreateView, UpdateView, DeleteView
from .forms import AddFarmForm, DeleteFarmForm, EditRecipeForm, CustomUserCreationForm, RecipeStepForm, RecipeIngredientForm
from .models import Amendment, AmendmentCategory, AmendmentElement, AmendmentType, Analysis, AnalysisItem
from .models import Country, Element, Farm, Field, Ingredient, Recipe, RecipeStep, RecipeIngredient, ReportItem, RecipeStep, SoilReport, Source, SourceAmendment, UserProfile
from .services import  AmendmentRatioService


# views for static pages


def about_view(request):
    """Render the about page."""
    print("About view is being called")
    return render(request, 'about.html')

def contact_view(request):
    """Render the contact page."""
    print("Contact view is being called")
    return render(request, 'contact.html')

def custom_logout(request):
    logout(request)
    print("User has logged out")
    return render(request, 'logged_out.html')

def get_ingredient(request, ingredient_id):
    try:
        ingredient = Ingredient.objects.select_related(
            'practice', 
            'ingredient_category', 
            'ingredient_type'
        ).get(pk=ingredient_id)

        ingredient_dict = model_to_dict(ingredient)
        # Manually include the related objects' information
        ingredient_dict['practice'] = str(ingredient.practice) if ingredient.practice else None
        ingredient_dict['ingredient_category'] = str(ingredient.ingredient_category) if ingredient.ingredient_category else None
        ingredient_dict['ingredient_type'] = str(ingredient.ingredient_type) if ingredient.ingredient_type else None
        return JsonResponse(ingredient_dict)
    except Ingredient.DoesNotExist:
        return JsonResponse({'error': 'Ingredient not found'}, status=404)
    
def get_recipe_step_details(request, recipe_step_id):
    try:
        steps = RecipeStep.objects.get(recipe_step_id=recipe_step_id)
        data = {
            'name': steps.recipe_step_name,
            'number': steps.recipe_step_number,
            'description': steps.recipe_step_description,
            'notes': steps.recipe_step_notes,
        }
        return JsonResponse(data)
    except RecipeStep.DoesNotExist:
        return JsonResponse({'error': 'Recipe step not found'}, status=404)

def get_recipe_ingredient_details(request, recipe_ingredient_id):
    try:
        ingredients = RecipeIngredient.objects.get(recipe_ingredient_id=recipe_ingredient_id)
         
        data = {
            'name': ingredients.recipe_step_name,
            'number': ingredients.recipe_step_number,
            'description': ingredients.recipe_step_description,
            'notes': ingredients.recipe_step_notes,
        }
        return JsonResponse(data)
    except RecipeStep.DoesNotExist:
        return JsonResponse({'error': 'Recipe step not found'}, status=404)

def get_ingredient_related(request, ingredient_id):
    try:
        ingredient = Ingredient.objects.select_related(
            'practice', 'ingredient_category', 'ingredient_type'
        ).get(pk=ingredient_id)

        # Construct the JSON response
        ingredient_data = {
            'ingredient_id': ingredient.id,
            'ingredient_name': ingredient.ingredient_name,
            'ingredient_description': ingredient.ingredient_description,
            'category_name': ingredient.ingredient_category.category_name,
            'type_name': ingredient.ingredient_type.ingredient_type_name,
            'practice_name': ingredient.practice.practice_name,
        }

        return JsonResponse(ingredient_data)
    except Ingredient.DoesNotExist:
        return JsonResponse({'error': 'Ingredient not found'}, status=404)
    
def home_view(request):
    """Render the home page."""
    print("Home view is being called")
    return render(request, 'home.html')

def index(request):
    return render(request, 'home.html')

def profile_view(request):
    """Render the profile page."""
    print("Profile view is being called")
    return render(request, 'profile.html')

@csrf_exempt
def save_steps_batch(request):
    if request.method == 'PATCH':
        try:
            steps_data = json.loads(request.body)
            for step_data in steps_data:
                recipe_step_id = step_data.get('recipe_step_id')
                if recipe_step_id:
                    # Update existing step
                    step = RecipeStep.objects.get(pk=recipe_step_id)
                else:
                    # Create new step
                    step = RecipeStep()

                step.recipe_step_name = step_data.get('recipe_step_name')
                step.recipe_step_number = step_data.get('recipe_step_number')
                step.recipe_step_description = step_data.get('recipe_step_description')
                step.recipe_step_notes = step_data.get('recipe_step_notes')
                # Make sure to set the recipe as well
                step.recipe_id = step_data.get('recipe_id')
                step.save()
            return JsonResponse({'status': 'Step details updated successfully', 'updated_steps': step_data})
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Invalid request'}, status=400)

class AmendmentController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def amendment_list(self, request):
        amendments = Amendment.objects.all()
        context = {'amendments': amendments.order_by('product_name')}
        return render(request, 'amendment_list.html', context)

    def amendment_detail(self, request, amendment_id):
        try:
            amendment = Amendment.objects.get(amendment_id=amendment_id)
        except Amendment.DoesNotExist:
            messages.error(request, f"Amendment ID {amendment_id} does not exist")
            return redirect('amendment_list')
        context = {
            'amendment': amendment
        }
        return render(request, 'amendment_detail.html', context)


class AnalysisController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def analysis_list(self, request):
        print("Analysis: GET ALL")
        analyses = Analysis.objects.all() 
        context = {'analyses': sorted(analyses, key=lambda analysis: analysis.analysis_date)}
        return render(request, 'analysis_list.html', context)

    def analysis_detail(request, analysis_id):
        try:
            analysis = Analysis.objects.get(analysis_id=analysis_id)
        except Analysis.DoesNotExist:
            messages.error(request, f"Analysis ID {analysis_id} does not exist")
            return redirect('analysis_list')
        context = {
            'analysis': analysis,
        }
        return render(request, 'analysis_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_analysis(self, request):
        if request.method == 'POST':
            analysis_date = request.POST.get('analysis_date')
            description = request.POST.get('description')
            soil_report_id = request.POST.get('soil_report_id')
            new_analysis = Analysis.objects.create(
                analysis_date=analysis_date,
                description=description,
                soil_report_id=soil_report_id
            )
            new_analysis.save()
            return redirect('analysis_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_analysis(self, request, analysis_id):
        analysis = get_object_or_404(Analysis, analysis_id=analysis_id)
        if request.method == 'POST':
            analysis.analysis_date = request.POST.get('analysis_date')
            analysis.description = request.POST.get('description')
            analysis.soil_report_id = request.POST.get('soil_report_id')
            analysis.save()
            return redirect('analysis_detail', analysis_id=analysis.analysis_id)

    # Delete operation
    def delete_analysis(self, request, analysis_id):
        analysis = get_object_or_404(Analysis, analysis_id=analysis_id)
        analysis.delete()
        return redirect('analysis_list')

class AnalysisItemController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def analysis_item_list(self, request):
        print("Analysis Item: GET ALL")
        analysis_items = AnalysisItem.objects.all() 
        context = {'analysis_items': sorted(analysis_items, key=lambda item: item.description)}
        return render(request, 'analysis_item_list.html', context)

    def analysis_item_detail(request, item_id):
        try:
            analysis_item = AnalysisItem.objects.get(item_id=item_id)
        except AnalysisItem.DoesNotExist:
            messages.error(request, f"Analysis Item ID {item_id} does not exist")
            return redirect('analysis_item_list')
        context = {
            'analysis_item': analysis_item,
        }
        return render(request, 'analysis_item_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_analysis_item(self, request):
        if request.method == 'POST':
            description = request.POST.get('description')
            analysis_id = request.POST.get('analysis_id')
            report_item_id = request.POST.get('report_item_id')
            new_analysis_item = AnalysisItem.objects.create(
                description=description,
                analysis_id=analysis_id,
                report_item_id=report_item_id
            )
            new_analysis_item.save()
            return redirect('analysis_item_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_analysis_item(self, request, item_id):
        analysis_item = get_object_or_404(AnalysisItem, item_id=item_id)
        if request.method == 'POST':
            analysis_item.description = request.POST.get('description')
            analysis_item.analysis_id = request.POST.get('analysis_id')
            analysis_item.report_item_id = request.POST.get('report_item_id')
            analysis_item.save()
            return redirect('analysis_item_detail', item_id=analysis_item.item_id)

    # Delete operation
    def delete_analysis_item(self, request, item_id):
        analysis_item = get_object_or_404(AnalysisItem, item_id=item_id)
        analysis_item.delete()
        return redirect('analysis_item_list')


class ElementController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def element_list(self, request):
        print("Element: GET ALL")
        elements = Element.objects.all() 
        context = {'elements': sorted(elements, key=lambda element: element.element_name)}
        return render(request, 'element_list.html', context)

    def element_detail(request, element_id):
        try:
            element = Element.objects.get(element_id=element_id)  
        except Element.DoesNotExist:
            messages.error(request, f"Element ID {element_id} does not exist")
            return redirect('element_list')
        context = {
            'element': element,
        }
        return render(request, 'element_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_element(self, request):
        if request.method == 'POST':
            element_name = request.POST.get('element_name')
            common_name = request.POST.get('common_name')
            element_symbol = request.POST.get('element_symbol')
            description = request.POST.get('description')
            new_element = Element.objects.create(
                element_name=element_name,
                common_name=common_name,
                element_symbol=element_symbol,
                description=description
            )
            new_element.save()
            return redirect('element_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_element(self, request, element_id):
        element = get_object_or_404(Element, element_id=element_id)
        if request.method == 'POST':
            element.element_name = request.POST.get('element_name')
            element.common_name = request.POST.get('common_name')
            element.element_symbol = request.POST.get('element_symbol')
            element.description = request.POST.get('description')
            element.save()
            return redirect('element_detail', element_id=element.element_id)

    # Delete operation
    def delete_element(self, request, element_id):
        element = get_object_or_404(Element, element_id=element_id)
        element.delete()
        return redirect('element_list')


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


# class RecipeCreateView(CreateView):
#     model = Recipe
#     fields = ['recipe_name', 'recipe_description', 'recipe_category', 
#               'recipe_type', 'recipe_application', 'recipe_practice', 
#               'recipe_notes', 'recipe_rate', 'recipe_rate_units']
#     template_name = 'recipe_form.html'
#     success_url = '/some-success-url/'

class RecipeListView(ListView):
    model = Recipe
    template_name = 'recipe.html'
    context_object_name = 'recipes'
    
    def get_queryset(self):
        # Order recipes by name
        # queryset = Recipe.objects.all().order_by('recipe_name')
        queryset = Recipe.objects.select_related('practice', 'application', 'unit').order_by('recipe_name')
        if self.request.user.is_authenticated:
            auth_user_id = self.request.user.id
            for recipe in queryset:
                recipe.is_owner = (auth_user_id == recipe.user_id)
        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Include curr_id in context to highlight the current recipe
        context['curr_id'] = self.request.GET.get('curr_id')
        return context

class RecipeUpdateView(UpdateView):
    model = Recipe
    form_class = EditRecipeForm
    template_name = 'recipe_form.html'
    pk_url_kwarg = 'recipe_id'

    def get_form(self, form_class=None):
        form = super().get_form(form_class)  # Get the form instance
        mode = self.request.GET.get('mode', '')
        is_edit_mode = (mode == 'edit')
        recipe_steps = RecipeStep.objects.filter(recipe_id=self.kwargs.get('recipe_id')).order_by('recipe_step_number')
        max_step_num = recipe_steps.last().recipe_step_number if recipe_steps.exists() else 0

        if not is_edit_mode:
            # Disable all form fields if not in edit mode
            for field_name, field in form.fields.items():
                field.disabled = True

        return form

    def get_success_url(self):
        # Make sure 'id' matches the name of your primary key field
        recipe_id = self.kwargs['recipe_id']
        return reverse_lazy('recipe_list') + '?curr_id=' + str(recipe_id)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        mode = self.request.GET.get('mode', '')
        context['IsEditMode'] = (mode == 'edit')
        context['recipe_id'] = self.kwargs.get('recipe_id', 'defaultID')
        context['step_form'] = RecipeStepForm()
        context['ingredient_form'] = RecipeIngredientForm()
    
        if self.object:  # Ensures we have a recipe object
            recipe_steps = self.object.recipestep_set.order_by('recipe_step_number').all()
            context['recipe_steps'] = recipe_steps
            first_step = context['recipe_steps'].first()
            context['step_form'] = RecipeStepForm(instance=first_step)

            # Serialize recipe ingredients to JSON
            # steps_json = serializers.serialize('json', recipe_steps)
            steps_json = json.dumps(list(recipe_steps.values()), cls=DjangoJSONEncoder)
            context['steps_json'] = steps_json
            
            # Disable step form fields if not in edit mode
            if not context['IsEditMode']:
                for field_name, field in context['step_form'].fields.items():
                    field.disabled = True
    
            # Disable ingredient form fields if not in edit mode
            if not context['IsEditMode']:
                for field_name, field in context['ingredient_form'].fields.items():
                    field.disabled = True
        
        else:
            context['recipe_steps'] = []
            # context['recipe_ingredients'] = []

        return context

class RecipeDeleteView(DeleteView):
    model = Recipe
    template_name = 'recipe_confirm_delete.html'
    success_url = reverse_lazy('recipe_list') # Adjust as necessary

    # def delete(self, request, *args, **kwargs):
    #     messages.success(request, 'Recipe was deleted successfully!')
    #     return super(RecipeDeleteView, self).delete(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        messages.success(request, 'The recipe was successfully deleted!')
        return super(RecipeDeleteView, self).post(request, *args, **kwargs)
    
    # def delete(self, request, *args, **kwargs):
    #     response = super(RecipeDeleteView, self).delete(request, *args, **kwargs)
    #     print(list(messages.get_messages(request)))  # Print messages for debugging
    #     return response


class ReportItemController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def report_item_list(self, request):
        print("ReportItem: GET ALL")
        report_items = ReportItem.objects.all() 
        context = {'report_items': sorted(report_items, key=lambda item: item.tested_element)}
        return render(request, 'report_item_list.html', context)

    def report_item_detail(request, item_id):
        try:
            report_item = ReportItem.objects.get(item_id=item_id)
        except ReportItem.DoesNotExist:
            messages.error(request, f"ReportItem ID {item_id} does not exist")
            return redirect('report_item_list')
        context = {
            'report_item': report_item,
        }
        return render(request, 'report_item_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_report_item(self, request):
        if request.method == 'POST':
            tested_element = request.POST.get('tested_element')
            unit = request.POST.get('unit')
            results = request.POST.get('results')
            target_ratio = request.POST.get('target_ratio')
            target_level = request.POST.get('target_level')
            report_id = request.POST.get('report_id')
            new_report_item = ReportItem.objects.create(
                tested_element=tested_element,
                unit=unit,
                results=results,
                target_ratio=target_ratio,
                target_level=target_level,
                report_id=report_id
            )
            new_report_item.save()
            return redirect('report_item_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_report_item(self, request, item_id):
        report_item = get_object_or_404(ReportItem, item_id=item_id)
        if request.method == 'POST':
            report_item.tested_element = request.POST.get('tested_element')
            report_item.unit = request.POST.get('unit')
            report_item.results = request.POST.get('results')
            report_item.target_ratio = request.POST.get('target_ratio')
            report_item.target_level = request.POST.get('target_level')
            report_item.report_id = request.POST.get('report_id')
            report_item.save()
            return redirect('report_item_detail', item_id=report_item.item_id)

    # Delete operation
    def delete_report_item(self, request, item_id):
        report_item = get_object_or_404(ReportItem, item_id=item_id)
        report_item.delete()
        return redirect('report_item_list')


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


class SoilReportController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def report_list(self, request):
        print("Report: GET ALL")
        reports = Report.objects.all()
        context = {'reports': sorted(reports, key=lambda report: report.report_name)}
        return render(request, 'report_list.html', context)

    def report_detail(request, report_id):
        try:
            report = Report.objects.get(report_id=report_id)
            report_fields = report.field_set.order_by('report_date')
        except Report.DoesNotExist:
            messages.error(request, f"Report ID {report_id} does not exist")
            return redirect('report_list')
        context = {
            'report': report,
            'report_fields': report_fields
        }
        return render(request, 'report_detail.html', context)

    # Create operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def create_report(self, request):
        if request.method == 'POST':
            report_date = request.POST.get('report_date')
            lab_name = request.POST.get('lab_name')
            field_id = request.POST.get('field_id')
            new_report = Report.objects.create(
                report_date=report_date,
                lab_name=lab_name,
                field_id=field_id
            )
            new_report.save()
            return redirect('report_list')

    # Update operation
    @csrf_exempt  # Using this decorator to allow POST requests
    def update_report(self, request, report_id):
        report = get_object_or_404(Report, report_id=report_id)
        if request.method == 'POST':
            report.report_date = request.POST.get('report_date')
            report.lab_name = request.POST.get('lab_name')
            report.field_id = request.POST.get('field_id')
            report.save()
            return redirect('report_detail', report_id=report.report_id)

    # Delete operation
    def delete_report(self, request, report_id):
        report = get_object_or_404(Report, report_id=report_id)
        report.delete()
        return redirect('report_list')


class SourceController(View):
    def __init__(self):
        self.api_key = settings.API_KEY

    @method_decorator(login_required(login_url='/accounts/login/'))
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def source_list(self, request):
        sources = Source.objects.all() 
        context = {'sources': sources.order_by('name')}
        return render(request, 'source_list.html', context)

    def source_detail(self, request, source_id):
        try:
            source = Source.objects.get(source_id=source_id)
        except Source.DoesNotExist:
            messages.error(request, f"Source ID {source_id} does not exist")
            return redirect('source_list')
        context = {
            'source': source
        }
        return render(request, 'source_detail.html', context)


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
