# Variables
STRAPI_DIR="/home/seh22/Projet_Saad" # Chemin pour accéder au projet Strapi
POSTGRES_HOST="localhost" # Adresse de l'hôte PostgreSQL
POSTGRES_PORT="5432" # Port PostgreSQL
POSTGRES_DB="postgres" # Nom de votre base de données PostgreSQL
POSTGRES_USER="strapi" # Nom d'utilisateur PostgreSQL
POSTGRES_PASSWORD="safepassword" # Mot de passe PostgreSQL

#Téléchargement des images docker des éléments consumers et producers
docker pull arthurescriou/product-producer:1.0.0
docker pull arthurescriou/product-consumer:1.0.3
docker pull arthurescriou/event-producer:1.0.3
docker pull arthurescriou/event-consumer:1.0.0
docker pull arthurescriou/stock-producer:1.0.1
docker pull arthurescriou/stock-consumer:1.0.0

#Création docker-compose.yml pour créer les conteneurs kafka, zookeeper, strapi...

#Création des conteneurs à partir du docker-compose.yml
docker-compose -f docker-compose.yml up -d

#Création des topics pour notre Kafka
#Création du topic product
docker exec -t kafka find / -name kafka-topics.sh
alias kafka-topics='docker exec -t kafka /opt/kafka_2.11-1.1.1/bin/kafka-topics.sh'

kafka-topics --zookeeper zookeeper:2181 --create --topic product --partitions 1 --replication-factor 1

#Création du topic event
kafka-topics --zookeeper zookeeper:2181 --create --topic event --partitions 1 --replication-factor 1

#Création du topic stock
kafka-topics --zookeeper zookeeper:2181 --create --topic stock --partitions 1 --replication-factor 1

#Création du topic error
kafka-topics --zookeeper zookeeper:2181 --create --topic error --partitions 1 --replication-factor 1

#Vérification si les topics ont bien été créés
kafka-topics --list --zookeeper zookeeper:2181

