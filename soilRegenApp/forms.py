import pandas as pd
import requests
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django import forms
from django.shortcuts import render, redirect
from django.urls import reverse

from .models import SoilReport, Farm, Recipe, Practice, Application, Unit


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
            'recipe_description': forms.TextInput(attrs={'required': True}),
            'recipe_category': forms.Select(),
            'recipe_type': forms.Select(),
            'practice': forms.Select(),
            'application': forms.Select(),
            'recipe_rate': forms.TextInput(attrs={'required': True}),
            'unit': forms.Select(),
            'recipe_notes': forms.Textarea(attrs={'required': True, 'rows': 4, 'cols': 40})
        }