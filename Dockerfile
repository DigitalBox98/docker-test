FROM ubuntu:20.04

# Installer les dépendances pour QEMU
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    wget

# Télécharger l'image HaikuOS (ici une image pre-built)
RUN wget https://download.haiku-os.org/releases/r1beta4/haiku-r1beta4-x86_64-anyboot.zip \
    && unzip haiku-r1beta4-x86_64-anyboot.zip -d /haiku

# Exposer le port SSH pour une connexion distante (si nécessaire)
EXPOSE 22

# Commande pour démarrer HaikuOS avec QEMU
CMD ["qemu-system-x86_64", "-m", "2G", "-hda", "/haiku/haiku-r1beta4-x86_64-anyboot.img", "-nographic", "-enable-kvm", "-redir", "tcp:2222::22"]

