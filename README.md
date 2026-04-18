# README

Group Members:
Simon Sapunar
Pablo Krumenaker
Renato Ilzauspe

Structure of the repository:

The EventHub repository is a Ruby on Rails application organized following standard conventions to ensure clarity and maintainability. 
At the root level, key configuration and dependency files include the README.md, which documents the project and should be updated from the default Rails template; the Gemfile and Gemfile.lock, which define and lock Ruby gem dependencies; the Rakefile for task automation; and config.ru for booting the application via Rack. Development and deployment are supported through files such as the Dockerfile for containerization and Procfile.dev for defining development processes, while package.json and yarn.lock manage JavaScript dependencies. The .ruby-version and .node-version files ensure consistent runtime environments, and .rubocop.yml enforces coding standards.
 The repository also contains project deliverables, including EventHub_Data_Model.png, which represents the database’s entity-relationship diagram, and User_Stories.pdf, which outlines system functionality from the user’s perspective. 
 The application’s core logic resides in the app/ directory, containing models, views, controllers, and related components, while config/ manages application settings and db/ stores database schemas and migrations. 
 Static assets, including the landing page, are located in public/, and executable scripts are found in bin/. Additional directories such as lib/tasks/ for custom tasks, log/ for runtime logs, tmp/ for temporary files, storage/ for uploaded content, and test/ for automated testing support the application’s operation. 
 The vendor/ folder contains external libraries not managed by Bundler, .github/ includes repository-specific configurations like workflows, .kamal/ handles deployment configuration, and script/ stores utility scripts. 
