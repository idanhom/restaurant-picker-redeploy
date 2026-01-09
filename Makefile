SHELL := /usr/bin/env bash

TF        ?= terraform
TF_DIR    ?= ./terraform
TFVARS    ?=
PLAN_OUT  ?= tfplan

.PHONY: help check fmt fmt-check init init-nobackend validate plan plan-fix apply destroy lint docs clean

help:
	@printf "%s\n" \
	"Targets:" \
	"  make fmt          - format (writes changes)" \
	"  make fmt-check    - fail if formatting differs" \
	"  make validate     - terraform validate (backend disabled)" \
	"  make check        - fmt-check + validate + lint" \
	"  make plan         - gated: fmt-check + validate + init + plan" \
	"  make plan-fix     - fmt (auto-fix) + validate + init + plan" \
	"" \
	"Vars:" \
	"  TF_DIR=path            (default '.') " \
	"  TFVARS='-var-file=...' (optional)" \
	"  PLAN_OUT=tfplan        (default 'tfplan')"

fmt:
	$(TF) -chdir=$(TF_DIR) fmt -recursive

fmt-check:
	$(TF) -chdir=$(TF_DIR) fmt -check -recursive -diff

init:
	$(TF) -chdir=$(TF_DIR) init

init-nobackend:
	$(TF) -chdir=$(TF_DIR) init -backend=false -upgrade

validate: init-nobackend
	$(TF) -chdir=$(TF_DIR) validate

lint:
	tflint --recursive

check: fmt-check validate lint

plan: fmt-check validate init
	$(TF) -chdir=$(TF_DIR) plan $(TFVARS) -out=$(PLAN_OUT)

plan-fix: fmt validate init
	$(TF) -chdir=$(TF_DIR) plan $(TFVARS) -out=$(PLAN_OUT)

apply: plan
	$(TF) -chdir=$(TF_DIR) apply $(PLAN_OUT)

destroy: init
	$(TF) -chdir=$(TF_DIR) destroy $(TFVARS)

docs:
	terraform-docs $(TF_DIR)

clean:
	rm -f $(PLAN_OUT)
