# nagelier

Inspirational Furniture.

LED chandelier that talks to the [fitbit](http://www.fitbit.com) API, and nags you with blinking lights when you're being too lazy for the day.

- If you've met your total goal for the day, the chandelier will transition between rainbow colors.
- If you're more than 50% behind your step goal, given the time of day, the chandelier will blink red and be angry at you.
- Otherwise, the chandelier a solid color that changes as you get closer to your goal.

nagelier was created at [2013 San Francisco Science Hack Day](http://sf.sciencehackday.com/2013/10/08/summarizing-science-hack-day-sf-2013/) and won the award for "Best Design".

## Video

https://vine.co/v/h6F0HT3YdgQ

## Hardware

Read the [instructables post](http://www.instructables.com/id/Nagelier-the-chandelier-that-nags-you-to-get-off-t/?ALLSTEPS) for details on hardware construction.

## Instructions

1. `git clone` this repo
2. `bundle`
3. Setup your API credentials, so we can read your data
    - `cp fitbit_api_credentials.yml.example fitbit_api_credentials.yml`
    - 'consumer' keys are created when you register your app at https://dev.fitbit.com/apps
    - per-user keys are created when you authorize the app to access your account. The easiest way to generate this is to use a command line script bundled with the python `fitbit` package.
        1. `pip install fitbit`
        2. `python /Library/Python/2.7/site-packages/fitbit/gather_keys_cli.py your_consumer_key your_consumer_secret`
4. install code to arduino and connect the Arduino via USB to your computer
5. `bundle exec bin/nagelier yourusername`
