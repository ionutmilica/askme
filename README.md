# ASKme

This is an Askfm clone made for learning Ruby on Rails development and deployment.

The assets were made by Andonie Alex.

### How to install:

```ssh
git clone git@github.com:ionutmilica/askme.git askme
cd askme
sudo apt-get install nodejs
sudo apt-get install libmagickwand-dev imagemagick
bundle install
rake db:migrate
rake db:seed # if you want some fake data
```

### Start the server
```ssh
rails s -b 0.0.0.0 -p 3000
```

### Screenshot
![Ask question](img/ask.png?raw=true "Ask")