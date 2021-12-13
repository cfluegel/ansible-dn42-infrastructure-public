.PHONY: clean updateall showhostvars showhostpeers tests test1 test2

clean:
	rm *.retry

newserver:
	ansible-playbook -i inventory -l newserver deploy-base-configuration.yml
	ansible-playbook -i inventory -l newserver install-packages.yml
	ansible-playbook -i inventory -l newserver deploy-fastd.yml
	ansible-playbook -i inventory -l newserver deploy-bird1.yml
# 	ansible-playbook -i inventory -l newserver deploy-bird2.yml
	ansible-playbook -i inventory -l newserver update-wireguard-peers.yml
	ansible-playbook -i inventory -l newserver update-bird1-peers.yml

updateall:
	ansible-playbook -i inventory update-packages.yml

checkpeerconnection:
	ansible-playbook -i inventory --extra-vars "newpeerip=$(IP)"  check-peering-connections.yml




## DEBUG Sections
showhostvars:
	ansible -i inventory all -m debug -a "var=hostvars[inventory_hostname]"

showhostvarstest:
	ansible -i inventory all -l testing -m debug -a "var=hostvars"

showhostpeers:
	ansible -i inventory all -m debug -a "var=hostvars[inventory_hostname].peers"

test1:
	ansible-playbook  -i inventory -l testing test1.yml

test2:
	ansible-playbook  -i inventory  -l testing test2.yml
