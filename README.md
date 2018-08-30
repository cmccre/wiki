# wiki (8/24/2018)

## Model

### Article

Each Article has the following attributes:

* **Revision ID:** A combination of publication date and true/false value indicating if it's the most-recent Article version
* **Title:** A unique string summarizing the Article and its revisions
* **Content:** Variable length, optionally HTML-rendered content that is the body of an Article revision
* **Author:** The User responsible for editing/publishing the Article revision
* **Requested Approval:** A true/false value indicating if the Article revision has been reported and administrative approval is being requested
* **Approved:** A true/false value indicating if the Article revision has received administrative approval
* **Tag List:** List of descriptive words associated with the Article revision to allow for more relevant Article search queries

### User

Each User has the following attributes:

* **Username:** A unique String used to identify a User
* **Password:** A 6-128 character phrase to authenticate a User
* **Is Admin:** A true/false value indicating if a User is an Admin type
* **Is Active:** A true/false value indicating if a User is allowed to edit the wiki
* **Is Locked-Out:** A true/false value indicating if a User is currently unable to login for a period of time after multiple falied login attempts

## Featured Behaviors

* Anyone may **Search** current Articles by Title, Tag, and/or Publication Date
* Anyone may **Browse** all Articles and their revisions
* Active Users may **Create** or **Edit** Articles, which may contain valid HTML content
* Active Users may **Tag** Articles with one or more descriptive terms
* Active Users may **Report** potentially inappropriate Articles, requesting Admin approval
* Active Users may **Update** their password or **Delete** their account
* Admin Users may **Ban** and **Un-Ban** Users from editing the wiki
* Admin Users may **Browse** all Users' Active status and Article revision publications
* Admin Users may **Delete** or **Approve** reported Articles
* Admin Users may **Browse** all Reported Articles

## View via Rails

* Clone wiki repo on local machine via Git
* cd into main wiki directory in a terminal
* run 'rails s' in the terminal
* point Internet browser to 'localhost:3000'
* sign-up as a User and explore (to set-up another admin User, or your own set of Users and Articles, edit seed.db and run 'rake db:seed')
