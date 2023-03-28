# Log Analyzer
This is a Ruby on Rails application that reads a log file containing logs in the following format:

  ```json
  {
    "env": "prod",
    "path": "/path1",
    "method": "PUT",
    "duration": "154",
    "statusCode": "594",
    "statusMessage": "status message 2",
    "host": "queroteste.com",
    "level": "LEVEL 2",
    "message": "message 1",
    "timestamp": "1679339588.550617"
  }
  ```
  The application processes the information and delivers a JSON where it is possible to view the path where the request was made and the number of successes and failures.

![status](https://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge)

## 💻 Development Stack
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
## :rocket: Features
- [x] Generates reports in JSON format based on the provided log.txt file.
- [x] Saves the file directly in the user's home directory when using the specified Docker command.
- [ ] Consumes real-time logs from an application.



## :memo: Index
- <a href="#getting_started">Getting Started </a>
- <a href="#setup">Setup </a>
- <a href="#author">Author </a>


<h2 id="getting_started">:checkered_flag: Getting Started </h2>

These instructions will help you to execute and generate a .json file with the report from the logs.txt file.
### Prerequisites
- Docker 20.10.20
- docker-compose 1.29.2

<h2 id="setup">:gear: Setup</h2>
Clone the repository:

```
$ git clone https://github.com/LuizGGoncalves/estagio_SRE.git
$ cd estagio_SRE
```

Start application:

```
$ docker compose build
$ docker compose up

```

After running the above commands, the output.json file will be located in the sre-intern-test folder, which is located in your home directory.

## Authors
<a href="https://www.linkedin.com/in/luiz-gustavo-carvalho-goncalves/">
 <img width=120px heith=120px style="border-radius: 50%" src="https://avatars.githubusercontent.com/u/89092600?v=4" alt="foto_autora"/></a>

