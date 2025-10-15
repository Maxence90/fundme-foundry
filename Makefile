-include .env

all: clean remove install update build

clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :
	forge install cyfrin/foundry-devops@latest --no-commit
	forge install smartcontractkit/chainlink-brownie-contracts@latest --no-commit  
	forge install foundry-rs/forge-std@latest --no-commit
# Update Dependencies
update:; forge update

build:; forge build

format :; forge fmt

deploy:
	@forge script script/DeployFundMe.s.sol:DeployFundMe $(shell echo $(NETWORK_ARGS))

deploy-sepolia:
	forge script script/DeployFundMe.s.sol --broadcast --fork-url $(SEPOLIA_RPC_URL) 
	--private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $
	(ETHERSCAN_API_KEY) -vvvv

deploy-zk:
	forge create src/FundMe.sol:FundMe 
	--rpc-url http://127.0.0.1:8011 
	--private-key $(DEFAULT_ZKSYNC_LOCAL_KEY) 
	--constructor-args $(shell forge create test/mock/MockV3Aggregator.sol:MockV3Aggregator --rpc-url http://127.0.0.1:8011 --private-key $(DEFAULT_ZKSYNC_LOCAL_KEY) --constructor-args 8 200000000000 --legacy --zksync | grep "Deployed to:" | awk '{print $$3}')
	--legacy --zksync
