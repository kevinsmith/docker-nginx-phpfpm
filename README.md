# klsmith/nginx-phpfpm

A reliable, highly-configurable nginx + php-fpm web server, available for PHP 5.6 and 7.1.

## Simple Example

Run the following in the command line:

```
docker run -d -p 8080:80 -e NGINX_ENABLE_AUTH=false klsmith/nginx-phpfpm:5.6-fpm
```

Point your browser to [http://localhost:8080](http://localhost:8080). You should see [a simple "Hello world!" page](#hello-world) that notes the container hostname and any environment variables.

## Hello world!

The single "Hello world!" `index.php` in this image is used to show a given container is working properly, and it's borrowed and heavily modified from [Docker Cloud's hello-world](https://github.com/docker/dockercloud-hello-world).

## Bug Reports

If you think you've found a bug, please post a good quality bug report in [this project's GitHub Issues](https://github.com/kevinsmith/docker-nginx-phpfpm/issues). Quoting from [Coen Jacobs](https://coenjacobs.me/2013/12/06/effective-bug-reports-on-github/), this is how you can best help me understand and fix the issue:

- The title **explains the issue** in just a couple words
- The description **is detailed enough** and contains at least:
  - **steps to reproduce** the issue
  - what the expected result is and **what actually happens**
  - the **version** of the software being used
  - versions of **relevant external software** (e.g. hosting platform, orchestrator, etc.)
- Explain **what you’ve already done** trying to fix this issue
- The report is **written in proper English**

## License

Copyright 2017 Kevin Smith

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
