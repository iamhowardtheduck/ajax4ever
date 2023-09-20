clear
echo -e "\n\n\n\n\n\n\n"
if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as \"root\" OR as \"sudo $USER\"; please try again." 1>&2
  exit 1
fi
sudo apt update -y
sudo apt install wget unzip openjdk-17-jre-headless git -y
cd /home/$USER && git clone https://github.com/ajpahl1008/simple-data-generator.git
cd /opt/ && sudo wget https://services.gradle.org/distributions/gradle-7.6.1-bin.zip && unzip gradle-7.6.1-bin.zip && sudo mv gradle-7.6.1 gradle
echo "export GRADLE_HOME=/opt/gradle" | sudo tee -a /etc/profile.d/gradle.sh
echo "export PATH=\${GRADLE_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
echo "What is your Elasticsearch endpoint?  Just the host, not the 'https://' or port."
read HOST
echo "What do you want your keystore password to be?"
read PASSWORD
echo "What port does Elasticsearch use?  If cloud, please enter 9243."
read PORT
cd /home/$USER/simple-data-generator && ./build_keystore.bash ${PASSWORD} ${HOST} ${PORT}
echo "Go forth and create a demo!"
exit
esac
done
