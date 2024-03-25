import pandas as pd
import requests
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django import forms
from django.shortcuts import render, redirect
from django.urls import reverse

from .models import SoilReport, Farm, Recipe


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