# SoilRegen Site portfolio management software Windows Desktop - written in Python, Django and html using OOP design.

# Overview

SoilRegen Site is intended to demonstrate the use of Python and Django to create a scalable website using MVC and OOP architecture. It's a basic farm portfolio managemeent program that conects to the MarketStack API to download a year of historical records for each farm that is entered. The initial account with the MarketStack is for up to 10,000 API calls per month, so please feel free to experiment with it. When a farm is first added to the portfolio a one year history for the farm is retrieved from the API, including the following fields:

date, open, high, low, close, volume, adj_high, adj_low, adj_close, adj_open, adj_volume, split_factor, dividend, symbol,exchange

These records are then stored in an sql database where they can be retrieved quickly for analysis. Add as many farms to the portfolio as desired, and each one will be retried upon adding. There is a significant delay when first adding a farm - this is not due to the the api or the data transfer, which happens within a second or two. The delay is caused by rendering the table in the farm detail screen with the hundreds of records that are returned. Pagination, and different forms of lazy loading have been explored, but as of this version the delay still exists when a farm is first added. After the initial add, retrieval and display of farm detail is nearly immediate.

An individual farm may be deleted or refreshed (have its price and other fields updated from the API) at any time either from the link on the farm detail view or from the portfolio view. When a farm is refreshed the updated farm information will then be stored in the SQL database.

The software is intended to show basic website syntax, structures and design using the python django framework.

# Web Pages

{Describe each of the web pages you created and how the web app transitions between each of them.  Also describe what is dynamically created on each page.}

The project includes the following web pages:

base.html
home.html

Farm pages:

farm_detail.html
add_farm.html
update_field.html
delete_farm.html

field_list.html
add_field.html
update_field.html
delete_field.html

Soil report pages:

report_list.html
report_detail.html
add_report.html
update_report.html
delete_report.html

Analysis pages:

analysis_list.html
analysis_detail.html
delete_analysis.html

Misc pages:

amendment_list.html
source_list.html

User management pages:

login.html
password_change_done.html
password_change.html
password_reset_complete.html
password_reset_confirm.html
password_reset_done.html
password_reset.html
signup.html

All of the web sites extend the base.html page, so the base.html page is visible at all times and all the other views load into it when called.

# Demo Video:

The following is a link to the demo video for this project: 


# Development Environment

The program is written in Python 3.11 using the Django framework, and VS Code. The environment was develope in Windows 10 Professional on an intel desktop.

## Requirements

Dependencies:

Python
Django
pandas
math
requests
date
datetime
json
os
sys
pathlib

In the present version the SQL data files are maintained in an SQLite3 database stored locally in the project directory. This was done for ease of testing and distribution.


# Resources

# Future Work


## How to use the software

To start the django server from within Python, open the project and then open a new terminal. Change directories to the project directory (soilRegenSite). From within the soilRegenSite directory, enter the following command: " python manage.py runserver "

This will start the server, and deliver the soilRegenApp website to localhost, where it is being delivered on port 8000. To open soilRegenApp in the browser, type the following command in the address bar: " http://127.0.0.1:8000/soilRegenApp/ "

The project also has a fully working admin site that can be accessed in the browser, where users and farms may be added or modified. To access the admin site, enter the following in a new browser window address bar:  " http://127.0.0.1:8000/admin/ "

To test the system the first time, try logging in to either the app site or the admin site using the following user credentials:

username: admin
password: 12345*AB

username: scottlefoll
password: 12345*AB

username: janedoe
password: 12345*AB

If none of those logins exist after the initial install, then run the following command from project directory within the terminal window: 

python manage.py createsuperuser

This will prompt for a username and a password, which will then allow access to the app site and the admin site.

When using the Reset Password feature from within the App, the feature sends out an "email" with a link for confirmation. This is not a live feature yet, and the email is actually created in a subfolder in the soilRegenSite project folder called " sent_emails ". After using the Reset Password feature and getting the completion message, there will be a new file in the sent_emails folder containing the " confirmation email ", with a link in it. Copy and paste that link into a new window on the browser address bar to confirm the password reset.

## Code Structure
The Django project has the following file structure:

soilRegenSite
    - sent_emails
    - soilRegenApp - contains the python .py files for the app
      - __pycache__
      - migrations
        - __pycache__
      - static
        - img
        - sql
        - soilRegenApp
          - css
          - js
      - templates - contains all of the app .html files
        - registration
    - soilRegenSite - contains the project .py files
    - manage.py
    - readme.md


The project contains the following modules:

forms.py - the Forms
models.py - the data Models
services - the business logic
urls.py - the url Patterns
utils.py - API Helper
views.py - the Controllers

The code is divided into the following classes:

Forms:


Models:


Utils:

APIs being referenced:

Views:

SignUpView
FarmController

The application is using the built-in auth User provided by Django.






