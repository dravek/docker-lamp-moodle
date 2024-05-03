# Docker LAMP for Moodle development

## Apache + PHP + MySQL + PhpMyAdmin and additional packages for Moodle development

- Creates a LAMP environment to install all Moodle instances you might need.

- **Note: This is a personal and WIP project.**

## Specifications

- When installing Moodle use the following settings:

```
$CFG->dbname    = 'mydb';
$CFG->dbuser    = 'root';
$CFG->dbpass    = 'test';
$CFG->dataroot  = '/var/www/data';
```

- Access webserver root page on <http://localhost:8000/>
- Access phpMyAdmin on <http://localhost:8001/>

## For xdebug in VSCode

- Replace "mywebserver" for the correct path on your machine.

```
{
    "name": "Listen for Xdebug",
    "type": "php",
    "request": "launch",
    "port": 9003,
    "pathMappings": {
        "/var/www/html/moodle/": "${userHome}/mywebserver/www/moodle"
    },
}
```
