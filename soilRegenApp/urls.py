
from django.urls import include, path
from django.views.generic import TemplateView
from .views import SignUpView, custom_logout
from . import views

urlpatterns = [

    # to render the home page without a view controller:
    path('', TemplateView.as_view(template_name="home.html"), name="home"),
    path('about/', views.about_view, name='about'),
    path('contact/', views.contact_view, name='contact'),
    path("signup/", SignUpView.as_view(), name="signup"),
    path("login/", views.login, name="login"),
    path('custom_logout/', views.custom_logout, name='custom_logout'),
    path("reset/", views.ResetView.as_view(), name="reset"),
    path('profile/', views.profile_view, name='profile'),

    path('recipes/', views.RecipeListView.as_view(), name='recipe_list'),
    path('recipes/<int:recipe_id>/', views.RecipeUpdateView.as_view(), name='recipe_detail'),
    path('recipe/update/<int:recipe_id>/', views.RecipeUpdateView.as_view(), name='edit_recipe'),
    # path('recipe/update/step/<int:recipe_step_id>/', views.RecipeUpdateStepView.as_view(), name='edit_recipe_step'),
    # path('recipe/update/ingredient/<int:recipe_ingredient_id>/', views.RecipeUpdateIngredientView.as_view(), name='edit_recipe_ingredient'),
    path('get-recipe-step-details/<int:recipe_step_id>/', views.get_recipe_step_details, name='get_recipe_step_details'),
    path('update_steps/', views.save_steps_batch, name='update_steps'),
    # path('get-ingredient/<int:ingredient_id>/', views.get_ingredient, name='get_ingredient'),
    # path('get-ingredient-related/<int:ingredient_id>/', views.get_ingredient_related, name='get_ingredient-related'),
    path('save-steps-batch/', views.save_steps_batch, name='save_steps_batch'),
    path('recipe/delete/<int:pk>/', views.RecipeDeleteView.as_view(), name='delete_recipe'),
]
