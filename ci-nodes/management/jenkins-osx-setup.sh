# Sets up OSX for connecting to Jenkins.  Run with sudo

if [ $1 = "" ]; then
    echo "Please supply dotnet-bot api key"
    exit 1
fi

# Install the unpacker
curl https://matell.blob.core.windows.net/unpacker/osx/unpacker -o /usr/local/bin/unpacker
chmod +x /usr/local/bin/unpacker

echo "curl https://raw.githubusercontent.com/dotnet/dotnet-ci/master/ci-nodes/startup/jenkins-osx-startup.sh -o /Library/LaunchDaemons/jenkins-osx-startup.sh"
curl https://raw.githubusercontent.com/dotnet/dotnet-ci/master/ci-nodes/startup/jenkins-osx-startup.sh -o /Library/LaunchDaemons/jenkins-osx-startup.sh
echo "curl https://raw.githubusercontent.com/dotnet/dotnet-ci/master/ci-nodes/startup/jenkins-osx-startup.plist | sed "s/<api key here>/$1/" > /Library/LaunchDaemons/jenkins-osx-startup.plist"
curl https://raw.githubusercontent.com/dotnet/dotnet-ci/master/ci-nodes/startup/jenkins-osx-startup.plist | sed "s/<api key here>/$1/" > /Library/LaunchDaemons/jenkins-osx-startup.plist
chmod +x /Library/LaunchDaemons/jenkins-osx-startup.sh
chown root:wheel /Library/LaunchDaemons/jenkins-osx-startup.sh
chown root:wheel /Library/LaunchDaemons/jenkins-osx-startup.plist
launchctl load /Library/LaunchDaemons/jenkins-osx-startup.plist