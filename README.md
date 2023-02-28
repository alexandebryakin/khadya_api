# Weuse API

# Initial setup

→ Clone the repo

→ Install `docker` and `docker-compose`

→ Copy env file by:

```bash
cp .example.env .env
```

→ Build docker by using:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml build
```

## Start the app in the `development` environment by:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml up -d
```

## Stop the app in the `development` environment by:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml down
```

## To run RSpecs:

```bash
# Creates and migrates test database
docker-compose -f ./docker-compose.yml -f ./docker/test/docker-compose.yml run --rm app rails db:create db:migrate

# Runs the specs
docker-compose -f ./docker-compose.yml -f ./docker/test/docker-compose.yml run --rm app rspec
# docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml --env-file .env.test run -e RAILS_ENV=test --rm app rspec
```

Types of meals:

```yaml
# [TODO]:
TODO:
  - !translations
      - translations: !IMPLEMENTATION_IDEA
          record_id: UUID
          record_type: [Restaurant | Meal | MealSetup ...]
          attribute_name: string
          language_code:

# [IDEAS]:
IDEAS:
  can be priced:
    - track restaurant's audience
    - send coupons to audience members based on some rules
    - generate leads based on app's user data (private)
    - ask audience to publish an IG, TT post|story|reel|video regarding the place and get a coupon for it
  table_schedules?: might be complicated
  create reservations:
  manage Wi-Fi credentials to display them to people that ordered smth:
  allow users to request translations: say, there is a user from Italy, that sees a page in English
    This user can create a translation request. Restaurant owner can gather the stats on which translations
    are more frequently requested & provide requested translations for their meals

# [Use Cases]:
Use Cases:
  multiple_people: # the same scenario can be also applied to a single person
    - a group of people come into a restaurant
    - choose a table
    - each person scans table's QR code:
      - at this point:
          - the web app opens
          - new table_session starts
          - users sees the restaurant's menu
    - for each user visiting the table at a certain time the app
      identifies a session with a, say, 10 minutes interval.
      During this 10 minutes interval each user has to start the
      process of ordering.
      If someone comes after this 10 minutes interval, a user from
      the session can generate a QR code and show it to that person.
    - choosing meals:
        - add an option to allow to order a, say, beverage at
          once and then proceed to other meals
        - hide or gray out the meals with user's forbidden ingredients
          depending on the user setting
    - complete an order:
        - at this point:
            - the cook receives the info regarding the rest of the meals
              that has to be cooked
    - wait for the order:
        - an app can approximately calculate the time before the meal is delivered
        - an app can show research modals like: 'How did you know about us?' in case this is the
          first time they visit the restaurant
    - eat the meals
    - order smth else while consuming food
    - bring the check (bill):
        - at this point:
            - the app should allow to bill the whole group or a set of particular individuals
            - situations:
                - one person: the scenario is simple -> just bring the bill
                - a group of 4 people and everyone pays for themselves separately:
                - a group of 4 people and one pays for all:
                - a group of 4 people and they are, say, 2 couples and each couple
                  pays for itself
                - POSSIBLE SOLUTION:
                    - Tap `Check`
                        - Select Individuals
                        - or tap `Just Me`
                          - at this point: the totals are displayed
                        - apply coupon
                        - tap the `Confirm` button # or smth like that
                          - at this point: the waiter will bring the check
                        - show the Tips page
                            - show possible options based on
                              the total amount in the check
                        - choose the payment method: ['cash', 'card']
                        - show the Rate page
                            - `Liked the place?` -> `Rate Us`


# [Parts of the App]
Parts of the App:
  public:
    - login
    - signup
    - generate anonymous user
    - see restaurant's page with menu
    - create a table_session via table's QR code
    - perform an order
    - search the restaurants nearby
  private:
    manage_personal_account:
      - manage user attributes (language, first & last name, phones, emails, passwords, etc...)
      - specify meal preferances
      - manage forbidden ingredients:
          - add forbidden ingredients
          - specify diet_tags (e.g. vegeterian, vegan, etc...)
          - settings:
              - For the food with forbidden ingredients: ['hide', 'gray out']
              - For the food with ingredients that do not fall under a diet tag: ['hide', 'gray out']
              - Preferrable payment method: ['cash', 'card']
      - manage payment method?: !IDEA
      - create a network
    staff_users:
      waiter:
        - pick up orders for delivery
        - mark orders as delivered
      cook:
        - mark a meal as not available (no ingrediets or something)
        - start perparing meals # it allows the app to approximetely calculate the remaing time


  admin:
    manage_tables:
      - generate QR codes
      - specify seats, etc...
    manage_menus:
      - create meals
      - specify ingredients for the meals
      - suggest an ingredient
    invite_people:
    assign_roles_and_permissions:
      - create custom roles
      - add roles to users
    duplicate_restaurants:
      - duplicate menus
    manage_wifi_credentials:
      - it is t


# [Entities Hierarchy]
Entities Hierarchy:
  users:
    roles:
      permissions:
  networks:
    restaurants:
      menus:
        meals:
          meal_setups:
            ingredients:
        eating_guidelines:
      tables:
      table_sessions:
        orders:
          order_items:

      coupons:


# [RELATIONSHIPS]
relationships:
  users: !DONE
    has_many: roles
  roles: !DONE
    has_many: permissions
  permissions: !DONE
    belongs_to: role
  users_roles: !DONE
    belongs_to: user
    belongs_to: role
  users_directly_assigned_permissions: !DONE # a set of permissions that can be assigned directly without using a role
    belongs_to: user
    belongs_to: permission

  networks:  !DONE
    has_many: restaurants
    belongs_to: user
  restaurants: !DONE
    has_one: menu # or `has_many` menus?
    has_many: coupons
  restaurant_employees: !DONE
    belongs_to: restaurant
    belongs_to: user
  reviews: !--skipped--
    belongs_to: user
    belongs_to: restaurant
  meals:
    belongs_to: meal_category # ?
    has_one: eating_guideline
    has_many: meal_setups
  meal_setups:
    belongs_to: meal
    has_many: ingredients
  meal_setups_ingredients:
    belongs_to: meal_setup
    belongs_to: ingredient

  eating_guidelines:
    belongs_to: meal
  menus:
    belongs_to: restaurant
  users_forbidden_ingredients:
    belongs_to: user
    belongs_to: ingredient
  coupons:
    belongs_to: restaurant
    belongs_to: user

  table_sessions:
    has_many: orders
    belongs_to: table
  orders:
    belongs_to: user
    belongs_to: table_session
    belongs_to: check
    has_many: order_items
  order_items:
    belongs_to: meal_setup
    belongs_to: order
  checks:
    has_many: orders
    has_one: tip
  tips:
    belongs_to: check


# [ATTRIBUTES]
attrs:
  users:
    - first_name
    - last_name
    - language_code # https://www.andiamo.co.uk/resources/iso-language-codes/
    - preferable_name?
    - kind: ['real', 'anonymous']
  users_forbidden_ingredients:
  roles:
    - name
    - code: !UNIQUE
    - type: ['app', 'custom']
  permissions:
    - name
    - code: !UNIQUE
  phones:
    - country_code
    - number
    - verification_status: [in_progress | succeeded | failed]
  emails:
    - email: string
    - verification_status: [in_progress | succeeded | failed]
    - is_primary: boolean
  networks:
    - name
    - ref:owner(user_id)
  restaurants:
    - name
    - location (lng & lat)
    - currency_code: string # USD
  restaurant_employees:
    - kind?: [owner | cook | waiter] # --or-- define via roles!
  reviews:
    rank: number (1 - 5)
    comment: text
    is_anonymous: boolean
  meals:
    - name
    - description
    - image_url
    - video_url?
    - cooking_duration: !IN_MINUTES
    - category:
        - beverage
        - etc.
  # meal_categories:
  #   - name
  meal_setups: # meal_adjustments
    - label: string
    - kind:
        - main # always in the order/check
        - size # only one size can be applied (there should be no `main` in this case)
        - addition # comes in conjunction with `main`.
    # - appliance_rule: ['always', 'one-of-kind', ]
    - available: boolean
    - kcalories: number
    - volume: number
    - volume_measurement: ['milliliters', 'grams']
    - price: decimal
  eating_guidelines:
    - content: text # We could later use Meta's `draftjs` lib to build beautiful guidelines
      # or we can use something like `steps`:
  tables:
    - name
    - number
    - seats_amount
  table_sessions:
    - id: uuid
    - ref:tables.id
    - created_at (started_at)
    - ended_at
    - status: ['started', 'finished', 'canceled']
  orders:
    - created_at
    - status: ['initial', 'in_progress', 'ordered', 'cooking', 'delivering', 'extending', 'waiting_paycheck', 'payed']
  order_items:
    - created_at
    - removed_at # in case a person decided to remove. Useful for restaurant's reports/stats
    - started_cooking_at
    - finished_cooking_at
    - delivered_at
  order_comments:
    - content: text # for example you can specify whether the food should be spicy or not
  checks: # bills
    - issued_at (or created_at?)
    - total_price # it can be valuable for reports/stats
  coupons:
    - code
    - expires_at
    - type?: ['general', 'personal'] # one-time | multi-time
    - discount_amount: number # 25
    - currency_code # USD

  table_schedules?:
    - ref:tables.id

  ingredients: !GLOBAL_TABLE
    - name: unique!
    - description
    - image_url
    - diet_tags?: ["vegan", "vegeterian", "sattvic"]
    - diet?:
        - vegeterian
        - vegan
        - non-vegeterian?

# [User Roles & Permissions]:
User Roles & Permissions:
  - role: waiter
    permissions:
      - can:a

# [Other Info]
Types Of Meals:
  breakfast: The first meal of the day. ...
  brunch: A meal eaten in the late morning, instead of BReakfast and lUNCH. ( ...
  elevenses: A snack (for example, biscuits and coffee). ...
  lunch: A meal in the middle of the day. ...
  tea: A light afternoon meal of sandwiches, cakes etc, with a drink of tea. ...
  supper: A light or informal evening meal. Around 6pm-7pm.
  dinner: The main meal of the day, eaten either in the middle of the day or in the evening. Usually when people say "dinner", they mean an evening, around 7pm-9pm.




```

```ruby
meals = [
  {
    name: 'Coffee'
    meal_adjustments: [
      {
        label: 'S',
        kind: 'size',
        appliance_rule: 'one-of-kind',
        kcalories: 60,
        volume: 250,
        volume_measurement: 'milliliters',
        price: 4.00 # USD
      },
      {
        label: 'M',
        kind: 'size',
        appliance_rule: 'one-of-kind',
        kcalories: 60,
        volume: 450,
        volume_measurement: 'milliliters'
        price: 5.00 # USD
      },
      # ...
    ]
  },
  {
    name: 'Orange Juice',
    meal_adjustments: [
      {
        label: 'generic',
        kind: 'none',
        appliance_rule: 'main', # means that this adjustment is included by default (main adjustment)
        kcalories: 45,
        volume: 500,
        volume_measurement: 'milliliters',
        price: 6.25 # USD
      }
    ]
  },
  {
    name: 'Pizza',
    meal_adjustments: [
      {
        label: 'generic',
        kind: 'none',
        appliance_rule: 'main',
        kcalories: 45,
        volume: 500,
        volume_measurement: 'milliliters',
        price: 6.25, # USD
        ingredients: [
          { name: 'Flour', ... },
          { name: 'Cheese', ... },
          ...
        ]
      },
      {
        label: 'Olives',
        kind: 'addition',
        appliance_rule: 'multiple', # it means that other adjustments can be specified
        kcalories: 45,
        volume: 50,
        volume_measurement: 'grams',
        price: 1.75 # USD
        ingredients: [
          {
            name: 'Olives',
            diet_tags: ['vegan', 'vegeterian']
          }
        ]
      },
      {
        label: 'Pineapple',
        kind: 'addition',
        appliance_rule: 'multiple', # it means that other adjustments can be specified
        kcalories: 45,
        volume: 50,
        volume_measurement: 'grams',
        price: 1.00 # USD
        ingredients: [
          {
            name: 'Pineapple',
            diet_tags: ['vegan', 'vegeterian']
          }
        ]
      },
    ]
  }
]

check = {
  orders: [
    {
      id: UUID,
      user: { ... },
      order_items: [
        {
          id: UUID,
          ...
          meal: { name: 'Coffee' }
          meal_adjustments: [
            {
              label: 'M',
              kind: 'size',
              appliance_rule: 'one-of-kind',
              kcalories: 60,
              volume: 450,
              volume_measurement: 'milliliters'
              price: 5.00 # USD
            },
          ]
        },
        {
          id: UUID,
          ...
          meal: { name: 'Pizza' },
          meal_adjustments: [
            { meal_adjustment_id: UUID, ... }, # main
            { meal_adjustment_id: UUID, amount: 2 }, # 'Pineapple'
            { meal_adjustment_id: UUID, amount: 1 }, # 'Olives'
          ]
        }
      ]
    }
  ]
}
```
