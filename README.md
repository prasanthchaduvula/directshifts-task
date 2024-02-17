# README

### Requirements:
- Create a RoR + React project. Integrate material-ui for react UI.
- Setup the bin/setup script to setup the project on local (including ‘bundle install’, database setup, ‘yarn/npm install’, etc.) and bin/dev script to run the server (should run both rails & react server)
- Use MySQL for database.
- Use Devise to authenticate. The signup/login should happen using Material UI.
- Make Devise work with APIs such that we can signup/login using APIs as well.
- A user should be able to send a referral email to any email address. The referral email should contain a link that redirects to sign up page.
- User’s home page should show all the email addresses that were referred.

## Configuration:
* Ruby version: 3.2.2 (Note: The assignment email mentioned that we should use ruby 3.0.1 but 3.2.2 is used because 3.0.1 is not maintained and having ruby build issues with latest macos. Thus, chose to go with the 3.2.2)

* Rails version: 7.0.8 (Note: The assignment email mentioned that we should use 7.0.1 but 7.0.8 is used because there was a security release after 7.0.1. Thus, chose to go with the 7.0.8)

## Installation

* System dependencies
  1. Ruby
  2. Bundler (`gem install bundler`)
  3. node (18.4.2)

#### Install any ruby package manager like [rvm](https://rvm.io/) [rbenv](https://github.com/rbenv/rbenv) [asdf](https://asdf-vm.com/#/core-manage-asdf) and [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

(**Tip**: To allow `nvm` to automatically detect and change node versions for
your project as you `cd` into the directory follow
[this](https://github.com/nvm-sh/nvm#deeper-shell-integration))

#### Install ruby 3.2.2

```bash
$ rvm install $(cat .ruby-version)
```

#### Install Node 18.4.2(can be skipped if you followed the tip mentioned in (3) above)

```bash
$ nvm install $(cat .nvmrc)
```

#### Install mysql

```bash
$ brew install mysql
```

## Setup

1. `cd direct_shifts_task`

#### Setup the app

```bash
$ bin/setup
```

#### Run app in local env

```bash
$ bin/setup # If it is not wokring for you then use the below command
```

or

```bash
$ foreman start -f Procfile.dev
```

#### Navigate to [http://localhost:3000/](http://localhost:3000/) or [http://0.0.0.0:3000](http://0.0.0.0:3000)


## Testing

#### How to run the test suite
1. `cd direct_shifts_assignment`
2. `rails test test/`

#### User Test credentials seed data

| status    | Email               | Password |
| -------- | ------------------- | -------- |
| User     | sam@example.com     | welcome |
| Joined   | oliver@example.com  | welcome |
| Pending  | john@doe.com        |  |


* Services (job queues, cache servers, search engines, etc.)

##  Code structure

#### High level backend structure
```
User(
  id,
  first_name,
  last_name,
  email,
  password
)

Invitation(
  id,
  email (Invitee email),
  sender_id (Fk Ref: Inviter user),
  expired_at
)
```

* Models (app/models)
  1. User
  2. Invitation

* Controllers (app/controllers)
  1. HomeController - entry point
  2. Api::V1::BaseController - base class for api
  3. Api::V1::SessionsController - for user login and logout
  4. Api::V1::InvitationsController - to invite and see all invitations

* Views (app/views)
  1. /home - serves the react root component for client side rendering
  2. /inviations - builds api response for invitations
  3. /mailers - serves the views for invitaation mailer

* Mailers (app/mailers)
  1. InvitationMailer - logic to send the invitation email

* Services (app/services)
  1. CreateInvitationService - creates the invitation

* Concerns (app/controllers/concerns)
  1. ApiResponders - to handle api responses and errors.
  2. ApiRescuable - api rescue handlers.
  3. Loggable - rails logger to log exceptions.
  4. Authenticable - token based authetnication for api endpoints for client side requests.


#### High level Client structure

- The application is served on a single entry point with `Home#index` where the React Router kicks in and `app/javascript/src/App.jsx` is the application entry component

* api (contains api endpoints - `app/javascript/src/apis`)
  1. api.js - Handles the axios interceptors and headers.
  2. auth.js - having all the api endpoints related to  authentication like signup, signin and logout.
  3. invitation.js - api endpoints related to create and view invitations.

* components (views - `app/javascript/src/components`)
  1. Main - Holds all the logic to routing and rendering components.
  2. Authentication - high level view components of SignUp, SignIn.
  3. Home - Renders Invite (to send the invitation) and list of all the invitations(if the invitation is sent by you then Sender Name is yours other wise it will display the the sender name of others who sent the invitation).
  4. NavBar - Renders the app header component with app namer and logout options.

* common (common components - `app/javascript/src/common`)
  1. Toastr - Display toast mesages for success and errors.
  2. logger - js logger to log catch errors.

* context (`app/javascript/src/contexts`)
  1. auth.jsx - Maintains authentication related context.
  2. user.jsx - Maintains user related context.

* reducers (`app/javascript/src/reducers`)
  1. auth.js - sets authetnication.
  2. user.js - sets the user.

* routes (serves both route and relative components - `app/javascript/src/routes`)
  1. auth.js - Auth routes like  `/signup`, `/signin`.
  2. dashboard.js - Home route `/`.

* utils (has utility components/functions  - `app/javascript/src/utils`)
  1. storage.js - Handles the client side storage.


#### APIs (Sign Up/Sign In)
* Sign Up
  - Path: `POST users`
  - Content-Type: `Application/JSON`
  - Sample body:
  ```
  {
    user: {
      first_name: 'Sam',
      last_name: 'Smith',
      email: 'sam@example.com',
      password: 'welcome',
      password_confirmation: 'welcome'
    }
  }
  ```
  - Sample successful response status: `201 Created`

* Sign In
  - Path: `POST /api/v1/sign_in`
  - Content-Type: `Application/JSON`
  - Sample body:
  ```
  {
    user: {
      email: 'sam@example.com',
      password: 'welcome',
    }
  }
  ```
  - Sample successful response status: `201 Created`
  - Response should contain header for `AuthToken` which can be used for authentication in consecutive requests.


* Invite
  - Path: `POST /api/v1/invitations`
  - headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-TOKEN": document
          .querySelector('[name="csrf-token"]')
          .getAttribute("content"),
        "X-Auth-Email": email,
        "X-Auth-Token": token,
    },
  - Sample body:
  ```
  {
    invitation: {
      email: 'john@example.com',
    }
  }
  ```
  - Sample successful response status: `201 Created`
  - Response should contain notice which will inform the user with toastr message

* Invitations
  - Path: `GET /api/v1/invitations`
  - headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-TOKEN": document
          .querySelector('[name="csrf-token"]')
          .getAttribute("content"),
        "X-Auth-Email": email,
        "X-Auth-Token": token,
    },
  ```
  - Response with all invitations so that we display invitaions sent by the current user and other users along with sender name.

### Scope for improvement
- The invitation architecture is kept simple and it relies currently on invited user signing up with the exact email added by the inviter user. In a more complex would, we could use something like Invitation code to keep track of the invite.
- Currently we are not tracking the emails status. Its better to handle the email delivery errors for better tracking.
- The mailer is not integrated, we could use an SMTP service or pre-provided templates with Mailchimp, etc for real world use cases.

- On the client, the structure is very simple. As the app grows more complex, we could separate components from views by having more styyled components and common components where views would be dumb components.
- I'm using the default material-ui theme, it can be deocrated more for better UI.
- The client currently shows the backend validation error message with the help of toastr but we can introduce frontend validation with help of formaik abd we can imporve the toastr messages.




