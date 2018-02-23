#!/bin/bash
curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true
