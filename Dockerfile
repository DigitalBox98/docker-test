FROM ubuntu:20.04

# Installer les dépendances pour QEMU
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    wget

# Télécharger l'image HaikuOS (ici une image pre-built)
RUN wget http://mirror.rit.edu/haiku/r1beta4/haiku-r1beta4-x86_64-anyboot.iso

# Exposer le port SSH pour une connexion distante (si nécessaire)
EXPOSE 22

# Commande pour démarrer HaikuOS avec QEMU
CMD ["qemu-system-x86_64", "-m", "2G", "-cdrom", "/haiku/haiku-r1beta4-x86_64-anyboot.iso", "-hda", "/haiku/haiku-disk.img", "-nographic", "-enable-kvm", "-netdev", "user,id=mynetwork,hostfwd=tcp::2222-:22", "-device", "virtio-net,netdev=mynetwork"]
