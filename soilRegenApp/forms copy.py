import pandas as pd
import requests
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django import forms
from django.shortcuts import render, redirect
from django.urls import reverse

from .models import Application, IngredientCategory, Farm, Ingredient,Recipe, RecipeStep, RecipeIngredient, Practice, SoilReport, Source, IngredientType, Unit


class AddSoilReportForm(forms.ModelForm):
    class Meta:
        model = SoilReport
        fields = ['report_date', 'lab_name', 'field']
        labels = {
            'report_date': 'Report Date',
            'lab_name': 'Lab Name',
            'field': 'Field'
        }
        widgets = {
            'report_date': forms.DateInput(attrs={'required': True}),
            'lab_name': forms.TextInput(attrs={'required': True}),
            'field': forms.Select(attrs={'required': True})
        }


class AddFarmForm(forms.ModelForm):
    class Meta:
        model = Farm
        fields = ['farm_name', 'street_address', 'town', 'state', 'zip']
        labels = {
            'Farm name': 'Name',
            'Street address': 'Street Address',
            'Town': 'Town',
            'State': 'State',
            'Zip': 'Zip'
        }
        widgets = {
            'farm_name': forms.TextInput(attrs={'required': True}),
            'street_address': forms.TextInput(attrs={'required': True}),
            'town': forms.TextInput(attrs={'required': True}),
            'state': forms.TextInput(attrs={'required': True}),
            'zip': forms.TextInput(attrs={'required': True})
        }


class CustomUserCreationForm(UserCreationForm):
    # Add any new fields if necessary
    email = forms.EmailField(required=True)
    password2 = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta(UserCreationForm.Meta):
        model = User
        fields = UserCreationForm.Meta.fields + ("username", "email", "password1", "password2")

    def __init__(self, *args, **kwargs):
        super(CustomUserCreationForm, self).__init__(*args, **kwargs)
        # customization of field labels
        self.fields['username'].label = 'username:'
        self.fields['email'].label = 'email:'
        self.fields['password1'].label = 'password:'
        self.fields['password2'].label = 'confirm password:'
        # modify help_texts here as needed
        # self.fields['username'].help_text = '150 characters or less. Letters and digits only.'
        # to completely remove the help text:
        self.fields['username'].help_text = None
        self.fields['email'].help_text = None

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data["email"]
        # Handle additional fields here
        if commit:
            user.save()
        return user


class DeleteSoilReportForm(forms.ModelForm):
    class Meta:
        model = SoilReport
        fields = []
        widgets = {'report_id': forms.HiddenInput()}


class DeleteFarmForm(forms.ModelForm):
    class Meta:
        model = Farm
        fields = []
        widgets = {'id': forms.HiddenInput()}


class RecipeForm(forms.ModelForm):
    class Meta:
        model = Recipe
        fields = ['recipe_name', 'recipe_notes']
        # Additional options like labels and widgets can be specified here

# class AddRecipeForm(forms.ModelForm):
#     class Meta:
#         model = Recipe
#         fields = ['recipe_name', 'recipe_description', 'recipe_category', 'recipe_type', 'application', 
#                   'practice', 'recipe_notes', 'recipe_rate', 'unit']
#                 #   'recipe_ingredients', 'recipe_steps']
#         labels = {
#             'Recipe Name': 'recipe_name',
#             'Description': 'recipe_description',
#             'Category': 'recipe_category',
#             'Type': 'recipe_type',
#             'Practice': 'practice',
#             'Application': 'application',
#             'Rate': 'recipe_rate',
#             'Units': 'unit',
#             'Notes': 'recipe_notes',
#         }
#         widgets = {
#             'recipe_name': forms.TextInput(attrs={'required': True}),
#             'recipe_description': forms.TextInput(attrs={'required': True}),
#             'recipe_category': forms.TextInput(attrs={'required': True}),
#             'recipe_type': forms.TextInput(attrs={'required': True}),
#             'practice': forms.TextInput(attrs={'required': True}),
#             'application': forms.TextInput(attrs={'required': True}),
#             'recipe_rate': forms.TextInput(attrs={'required': True}),
#             'unit': forms.TextInput(attrs={'required': True}),
#             'recipe_notes': forms.TextInput(attrs={'required': True}),
#         }
        
class EditRecipeForm(forms.ModelForm):
    # Explicitly define ModelChoiceFields for practice, application, and unit if you need custom behavior
    practice = forms.ModelChoiceField(queryset=Practice.objects.all(), empty_label="Select Practice", required=True)
    application = forms.ModelChoiceField(queryset=Application.objects.all(), empty_label="Select Application", required=True)
    unit = forms.ModelChoiceField(queryset=Unit.objects.all(), empty_label="Select Unit", required=True)

    class Meta:
        model = Recipe
        fields = ['recipe_name', 'recipe_description', 'recipe_category', 'recipe_type', 'application', 
                  'practice', 'recipe_rate', 'unit', 'recipe_notes']
                #    'recipe_ingredients', 'recipe_steps']
        labels = {
            'Recipe Name': 'recipe_name',
            'Description': 'recipe_description',
            'Category': 'recipe_category',
            'Type': 'recipe_type',
            'Practice': 'practice',
            'Application': 'application',
            'Rate': 'recipe_rate',
            'Units': 'unit',
            'Notes': 'recipe_notes',
        }
        widgets = {
            'recipe_name': forms.TextInput(attrs={'required': True}),
            'recipe_description': forms.TextInput(attrs={'id': 'id-recipe-category-select', 'required': True}),
            'recipe_category': forms.Select(attrs={'id': 'id-recipe-category-select', 'required': True}),
            'recipe_type': forms.Select(attrs={'id': 'id-recipe-type-select', 'required': True}),
            'practice': forms.Select(attrs={'id': 'id-practice-select', 'required': True}),
            'application': forms.Select(attrs={'id': 'id-application-select', 'required': True}),
            'recipe_rate': forms.TextInput(attrs={'required': True}),
            'unit': forms.Select(attrs={'id': 'id-recipe-unit-select', 'required': True}),
            'recipe_notes': forms.Textarea(attrs={'required': True, 'rows': 8, 'cols': 40})
        }
        
class RecipeStepForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RecipeStepForm, self).__init__(*args, **kwargs)
        self.fields['recipe_step_number'].disabled = True  # This makes the field non-editable but still submitted with the form

    class Meta:
        model = RecipeStep
        fields = ['recipe_step_number', 'recipe_step_name', 'recipe_step_description', 'recipe_step_notes']
        
        labels = {
            'recipe_step_name': 'Name',
            'recipe_step_number': 'Number',
            'recipe_step_description': 'Description',
            'recipe_notes': 'Notes',
        }
        widgets = {
            'recipe_step_name': forms.TextInput(attrs={'id': 'id_recipe_step_name','required': True}),
            'recipe_step_number': forms.TextInput(attrs={'id': 'id_recipe_step_number', 'required': True}),
            'recipe_step_description': forms.TextInput(attrs={'id': 'id_recipe_step_description', 'required': True}),
            'recipe_step_notes': forms.Textarea(attrs={'id': 'id_recipe_step_notes', 'required': True, 'rows': 6, 'cols': 40})
        }

class RecipeIngredientForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RecipeIngredientForm, self).__init__(*args, **kwargs)
        # Query the Ingredient model to get the related objects
        # self.fields['ingredient'].queryset = Ingredient.objects.all()
        unit = forms.ModelChoiceField(queryset=Unit.objects.all(), empty_label="Select Unit", required=True)
        category = forms.ModelChoiceField(queryset=IngredientCategory.objects.all(), empty_label="Select Category", required=True)
        type = forms.ModelChoiceField(queryset=IngredientType.objects.all(), empty_label="Select Type", required=True)
        
        # Explicitly defined for custom behavior
        # self.fields['source'].disabled = True
    
    class Meta:
        model = RecipeIngredient
        fields = ['recipe_ingredient_quantity', 'recipe_ingredient_notes', 'unit', 'source', 'ingredient']
        
        labels = {
            'ingredient': 'Ingredient',
            'source': 'Source',
            'recipe_ingredient_quantity': 'Quantity',
            'unit': 'Unit',
            'recipe_ingredient_notes': 'Notes',
        }

        widgets = {
            'ingredient': forms.Select(attrs={'id': 'id_recipe_ingredient_ingredient', 'class': 'form-control'}),
            'source': forms.Select(attrs={'id': 'id_recipe_ingredient_source', 'class': 'form-control'}),
            'recipe_ingredient_quantity': forms.NumberInput(attrs={'id': 'id_recipe_ingredient_quantity', 'required': True, 'class': 'form-control'}),            
            'unit': forms.Select(attrs={'id': 'id_recipe_ingredient_unit', 'class': 'form-control'}),
            'recipe_ingredient_notes': forms.Textarea(attrs={'id': 'id_recipe_ingredient_notes', 'required': True, 'rows': 4, 'cols': 40}),
        }
