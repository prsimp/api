# The Paul Simpson API
An API for accessing information for my application as a Junior Rails Developer at [Harvest](http://www.getHarvest.com).

## Introduction
I love APIs. I love them both for their systematic representation our data and for what they can become when used or combined in new and creative ways.

I also love [Harvest](http://www.getHarvest.com). I have been watching them for months as I prepare to move to New York in June. The care they put into crafting their product, the open-minded and flexible approach they have to managing a distributed company, and the unwavering and vocal love of their users have made me certain that Harvest is the sort of place I want to work, learn, and grow as a developer.

I built this API for Harvest in an attempt to display myself in a way that makes me happy and would show the fine folks at Harvest how serious I am about working with them. Enjoy!

#### Supported Data Formats
The Paul Simpson API supports both JSON and XML requests. The data-type to be returned can be specified in two ways: either by setting the <code>Accept</code> and <code>Content-type</code> headers in the request (<code>application/json</code> for JSON, <code>application/xml</code> for XML) or by adding the desired content-type to the end of a request (i.e. /users/prsimp.json). If no content-type is specified, JSON will be returned.

#### API Wrapper Libraries
Sadly, no wrapper libraries currently exist for The Paul Simpson API.

#### Contact Information
Questions, comments, concerns, outrage, requests for interviews, and/or offers of employment should be directed to prsimp@gmail.com.

## Usage
The root URL for The Paul Simpson API is <code>http://api.prsimp.com</code>. All requests are sent using the <code>GET</code> method. Ruby-style symbols are used to represent variable information in an API call. For instance, <code>:username</code> should be replaced with the username of the desired user.

### User Information
#### Get basic biographical information about a user
<code>GET /users/:username/whois</code>
###### Response
    {
      "name":"Paul Simpson",
      "email":"prsimp@gmail.com",
      "username":"prsimp",
      "age":27,
      "location":"Manhattan, Kansas",
      "url":"http://api.prsimp.com/users/prsimp"
    }

#### Get the full user record for a user
<code>GET /users/:username</code>
###### Response
    {
      "name":"Paul Simpson",
      "email":"prsimp@gmail.com",
      "username":"prsimp",
      "age":27,
      "location":"Manhattan, Kansas",
      "url":"http://api.prsimp.com/users/prsimp",
      "whois_url":"http://api.prsimp.com/users/prsimp/whois",
      "profiles":[
        {
          "site":"Github",
          "username":"prsimp",
          "profile_url":"https://github.com/prsimp/",
          "url":"http://api.prsimp.com/users/prsimp/profiles/1"
        },
        {
          ...
        }
      ],
      "facts":[
        {
          "title":"Company Culture",
          "body":"Harvest gives back to the OSS, local startup and international communities. This is important to me.",
          "fact_type":"Harvest",
          "url":"http://api.prsimp.com/users/prsimp/facts/1"
        },
        {
          ...
        }
      ]
    }

### Profile Information
Profiles are a user's presence on other websites (i.e. Github, Stack Overflow)
#### Get all profiles for a user
<code>GET /users/:username/profiles</code>
####### Response
    {
      "username":"prsimp",
      "url":"http://api.prsimp.com/users/prsimp",
      "profiles":[
        {
          "site":"Github",
          "username":"prsimp",
          "id": 1,
          "profile_url":"https://github.com/prsimp/",
          "url":"http://api.prsimp.com/users/prsimp/profiles/1"
        },
        {
          "site":"StackOverflow",
          "username":"Paul Simpson",
          "id": 2,
          "profile_url":"http://stackoverflow.com/users/1005071/paul-simpson",
          "url":"http://api.prsimp.com/users/prsimp/profiles/2"
        },
        {
          "site":"Twitter",
          "username":"prsimp",
          "id": 3,
          "profile_url":"https://twitter.com/#!/prsimp",
          "url":"http://api.prsimp.com/users/prsimp/profiles/3"
        },
        {
          "site":"Last.fm",
          "username":"parisim",
          "id": 4,
          "profile_url":"http://www.last.fm/user/parisim",
          "url":"http://api.prsimp.com/users/prsimp/profiles/4"
        }
      ]
    }

#### Get a single profile for a user
<code>GET /users/:username/profiles/:id</code>
###### Response
    {
      "username":"prsimp",
      "url":"http://api.prsimp.com/users/prsimp",
      "profile":
        {
          "site":"Github",
          "username":"prsimp",
          "id": 1,
          "profile_url":"https://github.com/prsimp/",
          "url":"http://api.prsimp.com/users/prsimp/profiles/1"
        }
    }

### User Facts
User facts represent information about a user in one of the following categories:
[Background and Recent Work](#background), [Why Harvest?](#harveset), and [Why Hire Me?](#hire).

#### Get all the facts for a user
<code>GET /users/:username/facts</code>
###### Response
    {
      "username":"prsimp",
      "url":"http://api.prsimp.com/users/prsimp",
      "facts":[
        {
          "fact_type":"Harvest",
          "title":"Company Culture",
          "body":"Harvest gives back to the OSS, local startup and international communities. This is important to me.",
          "id": 1,
          "url":"http://api.prsimp.com/users/prsimp/facts/1"
        },
        {
          ...
        }
      ]
    }

#### Get a single fact for a user
<code>GET /users/:username/facts/:id</code>
###### Response
    {
      "username":"prsimp",
      "url":"http://api.prsimp.com/users/prsimp",
      "fact":
        {
          "fact_type":"Harvest",
          "title":"Company Culture",
          "body":"Harvest gives back to the OSS, local startup and international communities. This is important to me.",
          "id":1,
          "url":"http://api.prsimp.com/users/prsimp/facts/1"
        }
    }

### <a id="background" href="#background">Background and Recent Work Facts</a>
Background and Recent Work facts relate to my Computer Science background and to
what I've been working on lately.
#### Get all background and recent work facts
<code>GET /users/:username/background</code>
###### Response
    {
      "username":"prsimp",
      "url":"http://api.prsimp.com/users/prsimp",
      "background":[
        {
          "title":"Formal Training",
          "body":"AP Computer Science (C++) in high school.",
          "id":11,
          "url":"http://api.prsimp.com/users/prsimp/facts/11"
        },
        {
          "title":"Formal Training",
          "body":"Intro to Java and Programming Java courses from North Carolina State University Engineering Online Program",
          "id":12,
          "url":"http://api.prsimp.com/users/prsimp/facts/12"
        },
        {
          "title":"Formal Training",
          "body":"Discrete Mathematics course from North Carolina State University Engineering Online Program",
          "id":13,
          "url":"http://api.prsimp.com/users/prsimp/facts/13"
        },
        {
          "title":"Self-Taught",
          "body":"Basic Ruby knowledge",
          "id":14,
          "url":"http://api.prsimp.com/users/prsimp/facts/14"
        },
        {
          "title":"Self-Taught",
          "body":"Basic Rails knowledge",
          "id":15,
          "url":"http://api.prsimp.com/users/prsimp/facts/15"
        },
        {
          "title":"Self-Taught",
          "body":"Intermediate HTML and CSS knowledge",
          "id":16,
          "url":"http://api.prsimp.com/users/prsimp/facts/16"
        }
      ],
      "recent":[
        {
          "title":"NYCorBUST",
          "body":"Built a rails application for aggregating items we were selling on Craigslist in preparation for the move. Visible at http://www.nycorbust.com or on Github at http://github.com/prsimp/nycorbust",
          "id":17,
          "url":"http://api.prsimp.com/users/prsimp/facts/17"
        },
        {
          "title":"US Army",
          "body":"Spent the last almost 3.5 years serving as an Infantry Officer in the United States Army",
          "id":18,
          "url":"http://api.prsimp.com/users/prsimp/facts/18"
        },
        {
          "title":"Paul Simpson API",
          "body":"Built this sweet API to display myself",
          "id":19,
          "url":"http://api.prsimp.com/users/prsimp/facts/19"
        }
      ]
    }

### <a id="harvest" href="#harvest">Why Harvest?</a>
<code>GET /users/:username/whyharvest</code>
###### Response
    {
      "username": "prsimp",
      "url": "http://api.prsimp.com/users/prsimp",
      "facts": [
        {
          "fact_type": "Harvest",
          "title": "Company Culture",
          "body": "Harvest gives back to the OSS, local startup and international communities. This is important to me.",
          "id": 1,
          "url": "http://api.prsimp.com/users/prsimp/facts/1"
        },
        {
          "fact_type": "Harvest",
          "title": "People Love It",
          "body": "I want to build something that people love because it makes their lives better.",
          "id": 2,
          "url": "http://api.prsimp.com/users/prsimp/facts/2"
        },
        {
          "fact_type": "Harvest",
          "title": "Coworkers",
          "body": "I want to work with people who are passionate about their craft, are honest, hard-working, and know how to enjoy work.",
          "id": 3,
          "url": "http://api.prsimp.com/users/prsimp/facts/3"
        },
        {
          "fact_type": "Harvest",
          "title": "Team Management",
          "body": "I like the open-minded and flexible approach to managing a distributed company.",
          "id": 4,
          "url": "http://api.prsimp.com/users/prsimp/facts/4"
        }
      ]
    }

### <a id="hire" href="#hire">Why Hire Me?</a>
<code>GET /users/:username/whyhire</code>
###### Response
    {
      "username": "prsimp",
      "url": "http://api.prsimp.com/users/prsimp",
      "facts": [
        {
          "fact_type": "Hire",
          "title": "Hungry",
          "body": "I am hungry to learn and grow as a developer.",
          "id": 5,
          "url": "http://api.prsimp.com/users/prsimp/facts/5"
        },
        {
          "fact_type": "Hire",
          "title": "Fast Learner",
          "body": "I am smart and learn very rapidly.",
          "id": 6,
          "url": "http://api.prsimp.com/users/prsimp/facts/6"
        },
        {
          "fact_type": "Hire",
          "title": "Calm",
          "body": "I've been trained to be comfortable in situations a bit out of my depth. On the job training often the best kind of experience.",
          "id": 7,
          "url": "http://api.prsimp.com/users/prsimp/facts/7"
        },
        {
          "fact_type": "Hire",
          "title": "Curious",
          "body": "I like to figure out what makes things tick.",
          "id": 8,
          "url": "http://api.prsimp.com/users/prsimp/facts/8"
        },
        {
          "fact_type": "Hire",
          "title": "Problem Solver",
          "body": "I am a natural problem solver",
          "id": 9,
          "url": "http://api.prsimp.com/users/prsimp/facts/9"
        },
        {
          "fact_type": "Hire",
          "title": "Team Player",
          "body": "I love working with other people and communicate well.",
          "id": 10,
          "url": "http://api.prsimp.com/users/prsimp/facts/10"
        }
      ]
    }

## Contributing
1. Fork the repository
2. Create a well-named branch for your changes.
3. Hack away
4. Send me a pull request!

## License
Copyright (c) 2012 Paul Simpson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.