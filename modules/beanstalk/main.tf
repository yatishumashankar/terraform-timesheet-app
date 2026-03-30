resource "aws_elastic_beanstalk_application" "app" {
  name = "timesheet-app"
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = "timesheet-env"
  application         = aws_elastic_beanstalk_application.app.name
  platform_arn = "arn:aws:elasticbeanstalk:ap-south-1::platform/Python 3.11 running on 64bit Amazon Linux 2"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.public_subnet_id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.security_group_id
  }
}
