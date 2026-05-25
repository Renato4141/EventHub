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

Make sure PostgreSQL is running on your machine. Then create and migrate the database:

```bash
rails db:create
rails db:migrate
```

### Seed the database

Populate the database with sample data:

```bash
rails db:seed
```

This will create:
- 5 users
- 6 events (in `draft`, `published`, and `finished` states)
- 5 categories
- 5 venues
- 13 registrations (in `confirmed`, `waitlisted`, and `cancelled` states)
- 4 reviews (only on finished events)

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

## Data Model

The relational diagram is included in the repository as `EventHub_Data_Model.png`.

Main entities and their relationships:

- **User** — organizes events and can register to or review others
- **Event** — belongs to a user (organizer) and a venue; has many registrations, reviews, and categories; rich text description via ActionText
- **Venue** — has many events; includes name, address, and capacity
- **Category** — associated to events through the `EventCategory` join table
- **Registration** — links a user to an event; has status (`confirmed`, `waitlisted`, `cancelled`)
- **Review** — written by a user for a finished event they attended; includes a rating (1–5) and a comment

---

## Repository Structure

```
EventHub/
├── app/
│   ├── controllers/    # Events, Venues, Categories, Registrations, Reviews, Users
│   ├── models/         # All models with associations, validations, and business logic
│   └── views/          # Full CRUD views for each entity
├── db/
│   ├── migrate/        # Database migrations (including ActionText tables)
│   ├── schema.rb       # Current database schema
│   └── seeds.rb        # Sample data
├── config/
│   └── routes.rb       # Resourceful routes
├── EventHub_Data_Model.png  # Entity-relationship diagram
└── README.md
```

---

## Main Features

### CRUD
- Create, edit, and cancel events with full form validation
- Full CRUD for venues and categories
- Register for events and cancel registrations from the event detail page
- Write reviews for completed events attended

### ActionText
- Event descriptions support rich text formatting (bold, italic, lists, links) via ActionText and the Trix editor

### Business Logic
- Events are created in `draft` status; organizers can publish or cancel them
- Registration is only allowed for `published` events
- When an event is at full capacity, new registrations are set to `waitlisted`
- When a confirmed attendee cancels, the first waitlisted user is automatically promoted to `confirmed`
- Users cannot register for the same event twice
- Users can only review events they attended (confirmed registration) after the event is finished

### Validations
- Presence validations across all models
- Event end date must be after start date
- Event capacity must be a positive integer and cannot exceed venue capacity
- Review rating must be between 1 and 5
- User-friendly error messages displayed inline using Bootstrap alert components

### Usability
- Event detail page serves as a hub: venue info, categories, registration count, available spots, registration/waitlist button, and reviews
- Bootstrap 5 styling throughout all views
- Top navigation bar for easy access to all sections
```