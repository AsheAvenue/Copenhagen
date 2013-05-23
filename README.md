Copenhagen is an inflexible, opinionated deployment framework for developers or orgs not willing or able to modify their deployment process. Rather than require you to change your process, Copenhagen wraps your existing process, whatever it may be.

## Installation

Install the gem from the command line:

    $ sudo gem install copenhagen

## Usage

Add a **Copenhagen.yml** file to your project root. Add one top-level node for each of your environments. Within each environment, define the deployment target and the attributes that correspond to the target. Example:

    test:
      target: heroku
      git_remote: heroku
      git_branch: master
      
    staging:
      target: remote-pull
      pem: /Users/tim/.pems/whatever.pem
      host: ec2-1-2-3-4.compute-1.amazonaws.com
      user: ubuntu
      remote_path: /var/www/test
      git_remote: origin
      
    production:
      target: remote-script
      pem: /Users/tim/.pems/whatever.pem
      host: ec2-1-2-3-4.compute-1.amazonaws.com
      user: ubuntu
      deploy_user: deploy
      deploy_script: push-whatever-to-prod-servers.sh
      
To deploy, simply run the dip command followed by the name of the environment. Example:

    $ dip staging

or

    $ dip production
    
In addition, if deploying to an environment using the **remote-pull** target, an optional branch can be passed in on the command line. If the branch isn't passed in, the current branch is used. For example, if you're on branch "test123", the following command will tell the remote server to checkout and pull the "feature123" branch:

    $ dip staging feature123 

##License

Copyright (c) 2013 Ashe Avenue

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
