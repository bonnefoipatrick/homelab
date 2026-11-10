# Homelab Proxmox + Talos

Infrastructure homelab sur un hôte Proxmox VE (mini PC, 16 Go) :

- **Cluster Kubernetes** : 3 nœuds Talos Linux (1 control-plane + 2 workers) sur réseau isolé `vmbr1` (10.10.10.0/24)
- **IDP** : Authentik (dans le cluster)
- **Reverse proxy** : Traefik (rupture protocolaire TLS, LoadBalancer MetalLB 10.10.10.100, forward-auth Authentik)
- **NAS** : TrueNAS SCALE (VM) avec backend S3/MinIO
- **Bastion d'admin** : VM Debian 12, seule VM joignable depuis le LAN (SSH par clé)
- **IaC** : OpenTofu (provider bpg/proxmox) + Ansible

## Plan d'adressage

| Élément | IP |
|---|---|
| vmbr1 (hôte PVE) | 10.10.10.1/24 |
| admin | 10.10.10.5 (+ DHCP LAN) |
| VIP Talos | 10.10.10.10 |
| talos-cp1 / w1 / w2 | 10.10.10.11 / .12 / .13 |
| TrueNAS | 10.10.10.20 (S3 : 9000) |
| MetalLB / Traefik | 10.10.10.100-120 (Traefik .100) |

## Ordre de déploiement

1. Préparer l'hôte : token API Proxmox pour Tofu, nftables activé.
2. `cd tofu && tofu init && tofu apply` : vmbr1, VMs Talos, admin, TrueNAS.
3. `ansible-playbook playbooks/admin.yml` : outillage du bastion.
4. Installer TrueNAS via son ISO (manuel, une fois) : IP 10.10.10.20, activer S3.
5. `ansible-playbook playbooks/talos.yml` : bootstrap du cluster.
6. `ansible-playbook playbooks/k8s-apps.yml` : MetalLB, Traefik, Authentik, ingress S3.
7. `ansible-playbook playbooks/proxmox-firewall.yml` : DNAT 443/80 + isolation LAN/lab.

## Isolation réseau

Aucune VM de service n'est attachée au LAN. Entrées autorisées :
- SSH vers la VM admin (firewall PVE, clé uniquement)
- DNAT 443/80 de l'hôte Proxmox vers Traefik (10.10.10.100)

Le lab ne peut pas initier de connexion vers le LAN (nftables forward policy drop).
