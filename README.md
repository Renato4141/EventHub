```markdown
# EventHub

**Group Members:**
- Simon Sapunar
- Pablo Krumenaker
- Renato Ilzauspe

EventHub is a Ruby on Rails application for managing events, registrations, and reviews. Users can create and manage events across different categories, register to attend them, and leave reviews once events are finished.

---

## Requirements

- Ruby 4.0
- Rails 8.1
- PostgreSQL
- Node.js & Yarn

---

## Setup Instructions

### Install Ruby dependencies
```bash
bundle install
```

### Install JavaScript dependencies
```bash
yarn install
```

### Configure the database
```bash
rails db:create
rails db:migrate
```

### Seed the database
```bash
rails db:seed
```

### Compile assets
```bash
rails assets:precompile
```

### Run the application
```bash
rails server
```

Then open your browser at [http://localhost:3000](http://localhost:3000).

---

## Test User Credentials

| Email | Password | Role |
|-------|----------|------|
| admin@eventhub.com | password123 | admin |
| alice@eventhub.com | password123 | regular |
| bob@eventhub.com | password123 | regular |
| carol@eventhub.com | password123 | regular |
| david@eventhub.com | password123 | regular |
| eva@eventhub.com | password123 | regular |

---

## Roles and Permissions

### Regular User
- Browse published events, venues, and categories
- Create events (starts as draft)
- Edit and cancel their own events
- Register for published events
- Cancel their own registrations
- Review events they attended (only finished events)

### Admin
- All regular user permissions
- Edit and cancel any event
- Manage categories (create, edit, delete)
- Manage venues (create, edit, delete)
- View and manage all users
- Delete any review

---

## Data Model

Main entities and their relationships:

- **User** — organizes events and can register to or review others
- **Event** — belongs to a user (organizer) and a venue; has many registrations, reviews, and categories
- **Venue** — has many events; includes name, address, and capacity
- **Category** — associated to events through the `EventCategory` join table
- **Registration** — links a user to an event; has status (`confirmed`, `waitlisted`, `cancelled`)
- **Review** — written by a user for a finished event they attended; includes a rating (1–5) and a comment

---

## Authentication (Devise)

Authentication is handled by Devise with support for:
- User registration (sign up)
- Login and logout
- Password recovery
- Account editing

## Authorization (Pundit)

Authorization is handled by Pundit with a policy class per resource. Unauthorized actions redirect the user with an appropriate error message.
```
