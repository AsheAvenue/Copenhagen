require "copenhagen/version"
require 'yaml'
require 'net/ssh'
require 'git'

module Copenhagen
  class Deploy

    def dip
      #get our environment
      environment = ARGV[0] #currently supported: 'staging' and 'production'

      #load the config file
      yaml = YAML.load(File.open("Copenhagen.yml"))
      
      #begin the deploy
      if(yaml[environment])
        puts "Dipping to #{environment}"
        
        #get the config for this environment
        config = yaml[environment]

        #get the deployment target. Currently supported: 'heroku', 'staging-pull', 'staging-script'
        if config['target'] == 'heroku'
          heroku config
        elsif config['target'] == 'remote-pull'
          remotepull config
        elsif config['target'] == 'remote-script'
          remotescript config
        end
        
      end
    end
    
    private 
    
    def heroku(config)
      git_remote = config['git_remote']
      git_branch = config['git_branch']
      
      if(git_remote && git_branch)
        puts "Pushing to Heroku"
        script = "git push #{git_remote} #{git_branch}"
        exec script
      else
        puts "Copenhagen requires git_remote and git_branch values to be set in Copenhagen.yml"
      end
    end
    
    def remotepull(config)
      pem = config['pem']
      host = config['host']
      user = config['user']
      remote_path = config['remote_path']
      git_remote = config['git_remote']
      
      if(pem && host && user && remote_path && git_remote)
        puts "SSHing into remote server and pulling code"
        
        #get the text of the pem
        pem_text = get_pem_text(pem)
        
        #get the git branch
        git_branch = ARGV[1]
        if !git_branch
          git_branch = `git branch | grep "*"`
          git_branch.gsub!("* ","")
        end
        
        #ssh in
        Net::SSH.start(host, user, :key_data => pem_text, :keys_only => TRUE) do |ssh|
          puts "Connected to host: #{host}"
          
          puts "Changing to project dir and pulling #{git_remote}/#{git_branch}"
          puts ssh.exec!("cd #{remote_path} && git fetch")
          puts ssh.exec!("cd #{remote_path} && git checkout #{git_branch}")
          puts ssh.exec!("cd #{remote_path} && git pull #{git_remote} #{git_branch}")
        end
        
      else
        puts "Copenhagen requires pem, host, remote_path, and git_remote values to be set in Copenhagen.yml"
      end
    end
    
    def remotescript(config)
      pem = config['pem']
      host = config['host']
      user = config['user']
      deploy_user = config['deploy_user']
      deploy_script = config['deploy_script']
      
      if(pem && host && deploy_user && deploy_script)
        puts "SSHing into remote server and running script"
        
        #get the text of the pem
        pem_text = get_pem_text(pem)
        
        #ssh in
        Net::SSH.start(host, user, :key_data => pem_text, :keys_only => TRUE) do |ssh|
          puts "Connected to host: #{host}"
          
          puts "Changing to #{deploy_user}'s home dir"
          ssh.exec!("cd /home/#{deploy_user}")
          
          puts "Running script: #{deploy_script}"
          puts ssh.exec!("./#{deploy_script}")
        end
        
      else
        puts "Copenhagen requires pem, host, remote_path, git_remote, and git_branch values to be set in Copenhagen.yml"
      end
    end
    
    def get_pem_text(pem)
      pem_file = open(File.expand_path(pem)) 
      pem_text = pem_file.read
      return pem_text
    end
    
  end
end
