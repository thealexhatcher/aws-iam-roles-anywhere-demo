
STACKNAME=TEST
REGION="us-east-1"

run:
	openssl genrsa -out private-key.pem 4096
	openssl req -new -x509 -key private-key.pem -out certificate.pem -days 365 -subj '/CN=US/OU=Example'
	openssl x509 -text -noout -in certificate.pem
	aws cloudformation deploy --stack-name $(STACKNAME) --template-file cfn.yml --parameter-overrides x509CertificateData=$$(cat certificate.pem) --output json
	#TODO jq stackoutputs to bash array 
	&& ./aws_signing_helper credential-process \
		--certificate certificate.pem \
		--region $(REGION) \
		--private-key private-key.pem \
		--profile-arn \
		--role-arn \
		--trust-anchor-arn

clean:
	aws cloudformation delete-stack --stack-name $(STACKNAME) && aws cloudformation wait stack-delete-complete --stack-name $(STACKNAME)