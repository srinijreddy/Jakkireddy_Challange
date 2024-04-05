### external ASG module ###
module "asg-external" {
  source = "terraform-aws-modules/autoscaling/aws"
  depends_on = [ module.external-alb ]
  # Autoscaling group
  name                = "${var.env_name}-asgexternal"
  use_name_prefix     = false
  instance_name       = "${var.env_name}-asginstanceexternal"
  min_size            = 1
  max_size            = 4
  desired_capacity    = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = module.vpc.public_subnets
  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  # Launch template
  launch_template_name        = "${var.env_name}-launchtemplate"
  launch_template_description = "Complete launch template example"
  user_data                   = base64encode(local.user_data_internal)
  image_id                    = var.ami
  key_name                    = var.key_name
  instance_type               = var.instance_type
  target_group_arns           = module.external-alb.target_group_arns
  security_groups             = [module.web-sg.security_group_id]

  # Target scaling policy schedule based on average CPU load
  scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    },
    predictive-scaling = {
      policy_type = "PredictiveScaling"
      predictive_scaling_configuration = {
        mode                         = "ForecastAndScale"
        scheduling_buffer_time       = 10
        max_capacity_breach_behavior = "IncreaseMaxCapacity"
        max_capacity_buffer          = 10
        metric_specification = {
          target_value = 32
          predefined_scaling_metric_specification = {
            predefined_metric_type = "ASGAverageCPUUtilization"
            resource_label         = "testLabel"
          }
          predefined_load_metric_specification = {
            predefined_metric_type = "ASGTotalCPUUtilization"
            resource_label         = "testLabel"
          }
        }
      }
    }
  }
}