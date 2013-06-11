![copenhagen](/img/logo.png)

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
      git_branch: whatever (optional)
      
    staging2:
      target: remote-pull-with-password
      host: ec2-1-2-3-4.compute-1.amazonaws.com
      user: ubuntu
      password: Wh4t3v3r
      remote_path: /var/www/test
      git_remote: origin
      (current branch will be used)
      
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

##Finally...

© 2013 <a href="http://www.asheavenue.com">Ashe Avenue</a>. Created by <a href="http://twitter.com/timboisvert">Tim Boisvert</a>.
<br />
Copenhagen is released under the <a href="http://opensource.org/licenses/MIT">MIT license</a>.
