#!/usr/bin/env python3
import json, subprocess, os, sys

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
TERRAFORM_DIR = os.path.abspath(
    os.path.join(BASE_DIR, "../../Terraform/envs/dev")
)

def tf_output():
    try:
        result = subprocess.run(
            ["terraform", "output", "-json"],
            cwd=TERRAFORM_DIR,
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError:
        print(json.dumps({"_meta": {"hostvars": {}}}))
        sys.exit(0)

tf = tf_output()

app = tf["ansible_inventory"]["value"]["app"]

inventory = {
    "app": {
        "hosts": ["app_server"]
    },
    "_meta": {
        "hostvars": {
            "app_server": {
                "ansible_connection": "aws_ssm",
                "ansible_aws_ssm_instance_id": app["instance_id"],
                "ansible_aws_ssm_region": app["region"],
                "ansible_aws_ssm_bucket_name": app["ssm_bucket"],
                "ansible_python_interpreter": "/usr/bin/python3"
            }
        }
    }
}

print(json.dumps(inventory, indent=2))
