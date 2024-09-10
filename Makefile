CONTRACT := $(word 2, $(MAKECMDGOALS))
ARGS := $(wordlist 3, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: update ZupRouter

update: 
	@forge clean && forge update

deploy: 
	@make update && forge script ${CONTRACT}Deploy --trezor --broadcast --rpc-url ${ARGS} --verify
