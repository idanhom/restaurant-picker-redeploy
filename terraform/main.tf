resource "azurerm_postgresql_flexible_server_configuration" "res-22" {
  name      = "DateStyle"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "ISO, MDY"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-23" {
  name      = "IntervalStyle"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "postgres"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-24" {
  name      = "TimeZone"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "UTC"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-25" {
  name      = "age.enable_containment"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-26" {
  name      = "allow_in_place_tablespaces"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-27" {
  name      = "allow_system_table_mods"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-28" {
  name      = "anon.algorithm"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "sha256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-29" {
  name      = "anon.k_anonymity_provider"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "k_anonymity"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-30" {
  name      = "anon.masking_policies"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "anon"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-31" {
  name      = "anon.maskschema"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "mask"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-32" {
  name      = "anon.privacy_by_default"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-33" {
  name      = "anon.restrict_to_trusted_schemas"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-34" {
  name      = "anon.salt"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-35" {
  name      = "anon.sourceschema"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "public"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-36" {
  name      = "anon.strict_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-37" {
  name      = "anon.transparent_dynamic_masking"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-38" {
  name      = "application_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-39" {
  name      = "archive_cleanup_command"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-40" {
  name      = "archive_command"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "BlobLogUpload.sh %f %p"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-41" {
  name      = "archive_library"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-42" {
  name      = "archive_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "always"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-43" {
  name      = "archive_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "300"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-44" {
  name      = "array_nulls"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-45" {
  name      = "authentication_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-46" {
  name      = "auto_explain.log_analyze"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-47" {
  name      = "auto_explain.log_buffers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-48" {
  name      = "auto_explain.log_format"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "text"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-49" {
  name      = "auto_explain.log_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-50" {
  name      = "auto_explain.log_min_duration"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-51" {
  name      = "auto_explain.log_nested_statements"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-52" {
  name      = "auto_explain.log_parameter_max_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-53" {
  name      = "auto_explain.log_settings"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-54" {
  name      = "auto_explain.log_timing"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-55" {
  name      = "auto_explain.log_triggers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-56" {
  name      = "auto_explain.log_verbose"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-57" {
  name      = "auto_explain.log_wal"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-58" {
  name      = "auto_explain.sample_rate"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1.0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-59" {
  name      = "autovacuum"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-60" {
  name      = "autovacuum_analyze_scale_factor"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-61" {
  name      = "autovacuum_analyze_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "50"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-62" {
  name      = "autovacuum_freeze_max_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "200000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-63" {
  name      = "autovacuum_max_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "3"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-64" {
  name      = "autovacuum_multixact_freeze_max_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "400000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-65" {
  name      = "autovacuum_naptime"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "60"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-66" {
  name      = "autovacuum_vacuum_cost_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-67" {
  name      = "autovacuum_vacuum_cost_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-68" {
  name      = "autovacuum_vacuum_insert_scale_factor"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-69" {
  name      = "autovacuum_vacuum_insert_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-70" {
  name      = "autovacuum_vacuum_scale_factor"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-71" {
  name      = "autovacuum_vacuum_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "50"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-72" {
  name      = "autovacuum_work_mem"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-73" {
  name      = "azure.accepted_password_auth_method"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "md5,scram-sha-256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-74" {
  name      = "azure.enable_temp_tablespaces_on_local_ssd"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-75" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-76" {
  name      = "azure.migration_copy_with_binary"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-77" {
  name      = "azure.migration_skip_analyze"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-78" {
  name      = "azure.migration_skip_extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-79" {
  name      = "azure.migration_skip_large_objects"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-80" {
  name      = "azure.migration_skip_role_user"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-81" {
  name      = "azure.migration_table_split_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "20480"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-82" {
  name      = "azure.service_principal_id"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-83" {
  name      = "azure.service_principal_tenant_id"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-84" {
  name      = "azure.single_to_flex_migration"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-85" {
  name      = "azure_cdc.change_batch_buffer_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "16"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-86" {
  name      = "azure_cdc.change_batch_export_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-87" {
  name      = "azure_cdc.max_fabric_mirrors"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "3"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-88" {
  name      = "azure_cdc.max_snapshot_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "3"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-89" {
  name      = "azure_cdc.onelake_buffer_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-90" {
  name      = "azure_cdc.parquet_compression"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "zstd"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-91" {
  name      = "azure_cdc.snapshot_buffer_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-92" {
  name      = "azure_cdc.snapshot_export_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "180"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-93" {
  name      = "azure_storage.allow_network_access"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-94" {
  name      = "azure_storage.blob_block_size_mb"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "128"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-95" {
  name      = "azure_storage.log_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-96" {
  name      = "azure_storage.public_account_access"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-97" {
  name      = "backend_flush_after"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-98" {
  name      = "backslash_quote"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "safe_encoding"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-99" {
  name      = "backtrace_functions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-100" {
  name      = "bgwriter_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "20"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-101" {
  name      = "bgwriter_flush_after"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "64"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-102" {
  name      = "bgwriter_lru_maxpages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-103" {
  name      = "bgwriter_lru_multiplier"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-104" {
  name      = "block_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8192"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-105" {
  name      = "bonjour"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-106" {
  name      = "bonjour_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-107" {
  name      = "bytea_output"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "hex"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-108" {
  name      = "check_function_bodies"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-109" {
  name      = "checkpoint_completion_target"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.9"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-110" {
  name      = "checkpoint_flush_after"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "32"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-111" {
  name      = "checkpoint_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "600"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-112" {
  name      = "checkpoint_warning"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-113" {
  name      = "client_connection_check_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-114" {
  name      = "client_encoding"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "UTF8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-115" {
  name      = "client_min_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "notice"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-116" {
  name      = "cluster_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-117" {
  name      = "commit_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-118" {
  name      = "commit_siblings"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-119" {
  name      = "compute_query_id"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "auto"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-120" {
  name      = "config_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/pg/data/postgresql.conf"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-121" {
  name      = "connection_throttle.bucket_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-122" {
  name      = "connection_throttle.enable"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-123" {
  name      = "connection_throttle.factor_bias"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-124" {
  name      = "connection_throttle.hash_entries_max"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "500"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-125" {
  name      = "connection_throttle.reset_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "120"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-126" {
  name      = "connection_throttle.restore_factor"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-127" {
  name      = "connection_throttle.update_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "20"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-128" {
  name      = "constraint_exclusion"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "partition"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-129" {
  name      = "cpu_index_tuple_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.005"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-130" {
  name      = "cpu_operator_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.0025"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-131" {
  name      = "cpu_tuple_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.01"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-132" {
  name      = "createrole_self_grant"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-133" {
  name      = "credcheck.auth_delay_ms"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-134" {
  name      = "credcheck.auth_failure_cache_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-135" {
  name      = "credcheck.encrypted_password_allowed"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-136" {
  name      = "credcheck.history_max_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "65535"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-137" {
  name      = "credcheck.max_auth_failure"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-138" {
  name      = "credcheck.no_password_logging"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-139" {
  name      = "credcheck.password_contain"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-140" {
  name      = "credcheck.password_contain_username"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-141" {
  name      = "credcheck.password_ignore_case"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-142" {
  name      = "credcheck.password_min_digit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-143" {
  name      = "credcheck.password_min_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-144" {
  name      = "credcheck.password_min_lower"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-145" {
  name      = "credcheck.password_min_repeat"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-146" {
  name      = "credcheck.password_min_special"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-147" {
  name      = "credcheck.password_min_upper"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-148" {
  name      = "credcheck.password_not_contain"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-149" {
  name      = "credcheck.password_reuse_history"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-150" {
  name      = "credcheck.password_reuse_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-151" {
  name      = "credcheck.password_valid_max"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-152" {
  name      = "credcheck.password_valid_until"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-153" {
  name      = "credcheck.reset_superuser"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-154" {
  name      = "credcheck.username_contain"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-155" {
  name      = "credcheck.username_contain_password"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-156" {
  name      = "credcheck.username_ignore_case"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-157" {
  name      = "credcheck.username_min_digit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-158" {
  name      = "credcheck.username_min_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-159" {
  name      = "credcheck.username_min_lower"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-160" {
  name      = "credcheck.username_min_repeat"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-161" {
  name      = "credcheck.username_min_special"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-162" {
  name      = "credcheck.username_min_upper"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-163" {
  name      = "credcheck.username_not_contain"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-164" {
  name      = "credcheck.whitelist"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-165" {
  name      = "credcheck.whitelist_auth_failure"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-166" {
  name      = "cron.database_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "postgres"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-167" {
  name      = "cron.enable_superuser_jobs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-168" {
  name      = "cron.host"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/tmp"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-169" {
  name      = "cron.launch_active_jobs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-170" {
  name      = "cron.log_min_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "warning"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-171" {
  name      = "cron.log_run"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-172" {
  name      = "cron.log_statement"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-173" {
  name      = "cron.max_running_jobs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "32"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-174" {
  name      = "cron.timezone"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "GMT"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-175" {
  name      = "cron.use_background_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-176" {
  name      = "cursor_tuple_fraction"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-177" {
  name      = "data_checksums"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-178" {
  name      = "data_directory"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/pg/data"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-179" {
  name      = "data_directory_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0700"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-180" {
  name      = "data_sync_retry"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-181" {
  name      = "db_user_namespace"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-182" {
  name      = "deadlock_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-183" {
  name      = "debug_assertions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-184" {
  name      = "debug_discard_caches"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-185" {
  name      = "debug_io_direct"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-186" {
  name      = "debug_logical_replication_streaming"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "buffered"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-187" {
  name      = "debug_parallel_query"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-188" {
  name      = "debug_pretty_print"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-189" {
  name      = "debug_print_parse"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-190" {
  name      = "debug_print_plan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-191" {
  name      = "debug_print_rewritten"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-192" {
  name      = "default_statistics_target"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-193" {
  name      = "default_table_access_method"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "heap"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-194" {
  name      = "default_tablespace"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-195" {
  name      = "default_text_search_config"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "pg_catalog.english"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-196" {
  name      = "default_toast_compression"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "lz4"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-197" {
  name      = "default_transaction_deferrable"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-198" {
  name      = "default_transaction_isolation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "read committed"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-199" {
  name      = "default_transaction_read_only"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-200" {
  name      = "duckdb.allow_community_extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-201" {
  name      = "duckdb.allow_unsigned_extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-202" {
  name      = "duckdb.autoinstall_known_extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-203" {
  name      = "duckdb.autoload_known_extensions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-204" {
  name      = "duckdb.disabled_filesystems"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "LocalFileSystem"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-205" {
  name      = "duckdb.enable_external_access"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-206" {
  name      = "duckdb.force_execution"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-207" {
  name      = "duckdb.max_memory"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-208" {
  name      = "duckdb.max_workers_per_postgres_scan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-209" {
  name      = "duckdb.memory_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-210" {
  name      = "duckdb.postgres_role"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "azure_pg_duckdb_admin"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-211" {
  name      = "duckdb.threads"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-212" {
  name      = "duckdb.worker_threads"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-213" {
  name      = "dynamic_library_path"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "$libdir"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-214" {
  name      = "dynamic_shared_memory_type"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "posix"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-215" {
  name      = "effective_cache_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "393216"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-216" {
  name      = "effective_io_concurrency"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-217" {
  name      = "enable_async_append"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-218" {
  name      = "enable_bitmapscan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-219" {
  name      = "enable_gathermerge"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-220" {
  name      = "enable_hashagg"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-221" {
  name      = "enable_hashjoin"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-222" {
  name      = "enable_incremental_sort"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-223" {
  name      = "enable_indexonlyscan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-224" {
  name      = "enable_indexscan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-225" {
  name      = "enable_material"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-226" {
  name      = "enable_memoize"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-227" {
  name      = "enable_mergejoin"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-228" {
  name      = "enable_nestloop"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-229" {
  name      = "enable_parallel_append"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-230" {
  name      = "enable_parallel_hash"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-231" {
  name      = "enable_partition_pruning"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-232" {
  name      = "enable_partitionwise_aggregate"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-233" {
  name      = "enable_partitionwise_join"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-234" {
  name      = "enable_presorted_aggregate"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-235" {
  name      = "enable_seqscan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-236" {
  name      = "enable_sort"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-237" {
  name      = "enable_tidscan"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-238" {
  name      = "escape_string_warning"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-239" {
  name      = "event_source"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "PostgreSQL"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-240" {
  name      = "exit_on_error"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-241" {
  name      = "external_pid_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-242" {
  name      = "extra_float_digits"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-243" {
  name      = "from_collapse_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-244" {
  name      = "fsync"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-245" {
  name      = "full_page_writes"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-246" {
  name      = "geqo"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-247" {
  name      = "geqo_effort"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-248" {
  name      = "geqo_generations"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-249" {
  name      = "geqo_pool_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-250" {
  name      = "geqo_seed"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-251" {
  name      = "geqo_selection_bias"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-252" {
  name      = "geqo_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "12"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-253" {
  name      = "gin_fuzzy_search_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-254" {
  name      = "gin_pending_list_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "4096"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-255" {
  name      = "gss_accept_delegation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-256" {
  name      = "hash_mem_multiplier"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-257" {
  name      = "hba_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/pg/data/pg_hba.conf"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-258" {
  name      = "hot_standby"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-259" {
  name      = "hot_standby_feedback"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-260" {
  name      = "huge_page_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-261" {
  name      = "huge_pages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "try"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-262" {
  name      = "icu_validation_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "warning"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-263" {
  name      = "ident_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/pg/data/pg_ident.conf"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-264" {
  name      = "idle_in_transaction_session_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-265" {
  name      = "idle_session_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-266" {
  name      = "ignore_checksum_failure"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-267" {
  name      = "ignore_invalid_pages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-268" {
  name      = "ignore_system_indexes"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-269" {
  name      = "in_hot_standby"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-270" {
  name      = "integer_datetimes"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-271" {
  name      = "intelligent_tuning"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-272" {
  name      = "intelligent_tuning.metric_targets"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-273" {
  name      = "jit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-274" {
  name      = "jit_above_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-275" {
  name      = "jit_debugging_support"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-276" {
  name      = "jit_dump_bitcode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-277" {
  name      = "jit_expressions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-278" {
  name      = "jit_inline_above_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "500000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-279" {
  name      = "jit_optimize_above_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "500000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-280" {
  name      = "jit_profiling_support"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-281" {
  name      = "jit_provider"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "llvmjit"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-282" {
  name      = "jit_tuple_deforming"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-283" {
  name      = "join_collapse_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-284" {
  name      = "krb_caseins_users"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-285" {
  name      = "krb_server_keyfile"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-286" {
  name      = "lc_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "en_US.utf8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-287" {
  name      = "lc_monetary"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "en_US.utf-8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-288" {
  name      = "lc_numeric"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "en_US.utf-8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-289" {
  name      = "lc_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "en_US.utf8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-290" {
  name      = "listen_addresses"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "*"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-291" {
  name      = "lo_compat_privileges"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-292" {
  name      = "local_preload_libraries"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-293" {
  name      = "lock_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-294" {
  name      = "log_autovacuum_min_duration"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "600000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-295" {
  name      = "log_checkpoints"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-296" {
  name      = "log_connections"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-297" {
  name      = "log_destination"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "stderr"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-298" {
  name      = "log_directory"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-299" {
  name      = "log_disconnections"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-300" {
  name      = "log_duration"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-301" {
  name      = "log_error_verbosity"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "default"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-302" {
  name      = "log_executor_stats"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-303" {
  name      = "log_file_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0600"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-304" {
  name      = "log_filename"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "postgresql-%Y-%m-%d_%H%M%S.log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-305" {
  name      = "log_hostname"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-306" {
  name      = "log_line_prefix"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "%t-%c-"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-307" {
  name      = "log_lock_waits"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-308" {
  name      = "log_min_duration_sample"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-309" {
  name      = "log_min_duration_statement"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-310" {
  name      = "log_min_error_statement"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "error"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-311" {
  name      = "log_min_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "warning"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-312" {
  name      = "log_parameter_max_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-313" {
  name      = "log_parameter_max_length_on_error"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-314" {
  name      = "log_parser_stats"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-315" {
  name      = "log_planner_stats"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-316" {
  name      = "log_recovery_conflict_waits"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-317" {
  name      = "log_replication_commands"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-318" {
  name      = "log_rotation_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "60"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-319" {
  name      = "log_rotation_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "102400"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-320" {
  name      = "log_startup_progress_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-321" {
  name      = "log_statement"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-322" {
  name      = "log_statement_sample_rate"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-323" {
  name      = "log_statement_stats"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-324" {
  name      = "log_temp_files"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-325" {
  name      = "log_timezone"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "UTC"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-326" {
  name      = "log_transaction_sample_rate"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-327" {
  name      = "log_truncate_on_rotation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-328" {
  name      = "logfiles.download_enable"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-329" {
  name      = "logfiles.retention_days"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "3"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-330" {
  name      = "logging_collector"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-331" {
  name      = "logical_decoding_work_mem"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "65536"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-332" {
  name      = "maintenance_io_concurrency"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-333" {
  name      = "maintenance_work_mem"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "157696"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-334" {
  name      = "max_connections"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "429"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-335" {
  name      = "max_files_per_process"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-336" {
  name      = "max_function_args"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-337" {
  name      = "max_identifier_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "63"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-338" {
  name      = "max_index_keys"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "32"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-339" {
  name      = "max_locks_per_transaction"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "64"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-340" {
  name      = "max_logical_replication_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "4"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-341" {
  name      = "max_parallel_apply_workers_per_subscription"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-342" {
  name      = "max_parallel_maintenance_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-343" {
  name      = "max_parallel_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-344" {
  name      = "max_parallel_workers_per_gather"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-345" {
  name      = "max_pred_locks_per_page"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-346" {
  name      = "max_pred_locks_per_relation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-347" {
  name      = "max_pred_locks_per_transaction"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "64"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-348" {
  name      = "max_prepared_transactions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-349" {
  name      = "max_replication_slots"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-350" {
  name      = "max_slot_wal_keep_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-351" {
  name      = "max_stack_depth"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2048"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-352" {
  name      = "max_standby_archive_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-353" {
  name      = "max_standby_streaming_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-354" {
  name      = "max_sync_workers_per_subscription"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-355" {
  name      = "max_wal_senders"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-356" {
  name      = "max_wal_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2048"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-357" {
  name      = "max_worker_processes"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-358" {
  name      = "metrics.autovacuum_diagnostics"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-359" {
  name      = "metrics.collector_database_activity"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-360" {
  name      = "metrics.pgbouncer_diagnostics"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-361" {
  name      = "min_dynamic_shared_memory"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-362" {
  name      = "min_parallel_index_scan_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "64"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-363" {
  name      = "min_parallel_table_scan_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-364" {
  name      = "min_wal_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "80"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-365" {
  name      = "old_snapshot_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-366" {
  name      = "parallel_leader_participation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-367" {
  name      = "parallel_setup_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-368" {
  name      = "parallel_tuple_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0.1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-369" {
  name      = "password_encryption"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "scram-sha-256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-370" {
  name      = "pg_failover_slots.drop_extra_slots"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-371" {
  name      = "pg_failover_slots.primary_dsn"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-372" {
  name      = "pg_failover_slots.standby_slot_names"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "azure_standby_, wal_replica_"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-373" {
  name      = "pg_failover_slots.standby_slots_min_confirmed"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-374" {
  name      = "pg_failover_slots.synchronize_slot_names"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "name_like:%%"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-375" {
  name      = "pg_failover_slots.version"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1.0.1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-376" {
  name      = "pg_failover_slots.wait_for_inactive_slots"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-377" {
  name      = "pg_hint_plan.debug_print"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-378" {
  name      = "pg_hint_plan.enable_hint"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-379" {
  name      = "pg_hint_plan.enable_hint_table"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-380" {
  name      = "pg_hint_plan.hints_anywhere"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-381" {
  name      = "pg_hint_plan.message_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-382" {
  name      = "pg_hint_plan.parse_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "info"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-383" {
  name      = "pg_partman_bgw.analyze"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-384" {
  name      = "pg_partman_bgw.dbname"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-385" {
  name      = "pg_partman_bgw.interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "3600"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-386" {
  name      = "pg_partman_bgw.jobmon"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-387" {
  name      = "pg_partman_bgw.maintenance_wait"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-388" {
  name      = "pg_partman_bgw.role"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-389" {
  name      = "pg_prewarm.autoprewarm"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-390" {
  name      = "pg_prewarm.autoprewarm_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "300"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-391" {
  name      = "pg_qs.interval_length_minutes"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "15"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-392" {
  name      = "pg_qs.is_enabled_fs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-393" {
  name      = "pg_qs.max_captured_queries"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "500"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-394" {
  name      = "pg_qs.max_plan_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "7500"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-395" {
  name      = "pg_qs.max_query_text_length"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "6000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-396" {
  name      = "pg_qs.parameters_capture_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "capture_parameterless_only"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-397" {
  name      = "pg_qs.query_capture_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-398" {
  name      = "pg_qs.retention_period_in_days"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "7"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-399" {
  name      = "pg_qs.store_query_plans"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-400" {
  name      = "pg_qs.track_utility"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-401" {
  name      = "pg_stat_statements.max"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-402" {
  name      = "pg_stat_statements.save"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-403" {
  name      = "pg_stat_statements.track"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-404" {
  name      = "pg_stat_statements.track_planning"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-405" {
  name      = "pg_stat_statements.track_utility"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-406" {
  name      = "pgaadauth.enable_group_sync"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-407" {
  name      = "pgaudit.log"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-408" {
  name      = "pgaudit.log_catalog"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-409" {
  name      = "pgaudit.log_client"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-410" {
  name      = "pgaudit.log_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-411" {
  name      = "pgaudit.log_parameter"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-412" {
  name      = "pgaudit.log_parameter_max_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-413" {
  name      = "pgaudit.log_relation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-414" {
  name      = "pgaudit.log_rows"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-415" {
  name      = "pgaudit.log_statement"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-416" {
  name      = "pgaudit.log_statement_once"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-417" {
  name      = "pgaudit.role"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-418" {
  name      = "pglogical.batch_inserts"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-419" {
  name      = "pglogical.conflict_log_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-420" {
  name      = "pglogical.conflict_resolution"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "apply_remote"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-421" {
  name      = "pglogical.extra_connection_options"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-422" {
  name      = "pglogical.synchronous_commit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-423" {
  name      = "pglogical.temp_directory"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-424" {
  name      = "pglogical.use_spi"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-425" {
  name      = "pgms_stats.is_enabled_fs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-426" {
  name      = "pgms_wait_sampling.history_period"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "100"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-427" {
  name      = "pgms_wait_sampling.is_enabled_fs"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-428" {
  name      = "pgms_wait_sampling.query_capture_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-429" {
  name      = "plan_cache_mode"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "auto"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-430" {
  name      = "port"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5432"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-431" {
  name      = "post_auth_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-432" {
  name      = "postgis.gdal_enabled_drivers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "DISABLE_ALL"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-433" {
  name      = "pre_auth_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-434" {
  name      = "primary_conninfo"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-435" {
  name      = "primary_slot_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-436" {
  name      = "quote_all_identifiers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-437" {
  name      = "random_page_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-438" {
  name      = "recovery_end_command"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-439" {
  name      = "recovery_init_sync_method"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "fsync"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-440" {
  name      = "recovery_min_apply_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-441" {
  name      = "recovery_prefetch"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "try"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-442" {
  name      = "recovery_target"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-443" {
  name      = "recovery_target_action"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "pause"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-444" {
  name      = "recovery_target_inclusive"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-445" {
  name      = "recovery_target_lsn"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-446" {
  name      = "recovery_target_name"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-447" {
  name      = "recovery_target_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-448" {
  name      = "recovery_target_timeline"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "latest"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-449" {
  name      = "recovery_target_xid"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-450" {
  name      = "recursive_worktable_factor"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-451" {
  name      = "remove_temp_files_after_crash"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-452" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-453" {
  name      = "reserved_connections"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-454" {
  name      = "restart_after_crash"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-455" {
  name      = "restore_command"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-456" {
  name      = "restrict_nonsystem_relation_kind"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-457" {
  name      = "row_security"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-458" {
  name      = "scram_iterations"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "4096"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-459" {
  name      = "search_path"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "\"$user\", public"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-460" {
  name      = "segment_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "131072"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-461" {
  name      = "send_abort_for_crash"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-462" {
  name      = "send_abort_for_kill"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-463" {
  name      = "seq_page_cost"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-464" {
  name      = "server_encoding"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "UTF8"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-465" {
  name      = "server_version"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "16.11"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-466" {
  name      = "server_version_num"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "160011"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-467" {
  name      = "session_preload_libraries"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-468" {
  name      = "session_replication_role"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "origin"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-469" {
  name      = "shared_buffers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "131072"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-470" {
  name      = "shared_memory_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1125"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-471" {
  name      = "shared_memory_size_in_huge_pages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "563"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-472" {
  name      = "shared_memory_type"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "mmap"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-473" {
  name      = "shared_preload_libraries"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "pg_cron,pg_stat_statements"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-474" {
  name      = "squeeze.max_xlock_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-475" {
  name      = "squeeze.worker_autostart"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-476" {
  name      = "squeeze.worker_role"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-477" {
  name      = "squeeze.workers_per_database"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-478" {
  name      = "ssl"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-479" {
  name      = "ssl_ca_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/certs/ca.pem"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-480" {
  name      = "ssl_cert_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/certs/cert.pem"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-481" {
  name      = "ssl_ciphers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-482" {
  name      = "ssl_crl_dir"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-483" {
  name      = "ssl_crl_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-484" {
  name      = "ssl_dh_params_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-485" {
  name      = "ssl_ecdh_curve"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "prime256v1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-486" {
  name      = "ssl_key_file"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/datadrive/certs/key.pem"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-487" {
  name      = "ssl_library"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "OpenSSL"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-488" {
  name      = "ssl_max_protocol_version"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-489" {
  name      = "ssl_min_protocol_version"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "TLSv1.2"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-490" {
  name      = "ssl_passphrase_command"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-491" {
  name      = "ssl_passphrase_command_supports_reload"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-492" {
  name      = "ssl_prefer_server_ciphers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-493" {
  name      = "standard_conforming_strings"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-494" {
  name      = "statement_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-495" {
  name      = "stats_fetch_consistency"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "cache"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-496" {
  name      = "superuser_reserved_connections"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-497" {
  name      = "synchronize_seqscans"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-498" {
  name      = "synchronous_commit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-499" {
  name      = "synchronous_standby_names"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-500" {
  name      = "syslog_facility"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "local0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-501" {
  name      = "syslog_ident"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "postgres"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-502" {
  name      = "syslog_sequence_numbers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-503" {
  name      = "syslog_split_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-504" {
  name      = "tcp_keepalives_count"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "9"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-505" {
  name      = "tcp_keepalives_idle"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "120"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-506" {
  name      = "tcp_keepalives_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "30"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-507" {
  name      = "tcp_user_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-508" {
  name      = "temp_buffers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-509" {
  name      = "temp_file_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "-1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-510" {
  name      = "temp_tablespaces"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-511" {
  name      = "timescaledb.bgw_launcher_poll_time"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "60000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-512" {
  name      = "timescaledb.disable_load"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-513" {
  name      = "timescaledb.max_background_workers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "16"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-514" {
  name      = "timescaledb_osm.disable_load"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-515" {
  name      = "timezone_abbreviations"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "Default"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-516" {
  name      = "trace_notify"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-517" {
  name      = "trace_recovery_messages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "log"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-518" {
  name      = "trace_sort"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-519" {
  name      = "track_activities"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-520" {
  name      = "track_activity_query_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1024"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-521" {
  name      = "track_commit_timestamp"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-522" {
  name      = "track_counts"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-523" {
  name      = "track_functions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "none"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-524" {
  name      = "track_io_timing"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-525" {
  name      = "track_wal_io_timing"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-526" {
  name      = "transaction_deferrable"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-527" {
  name      = "transaction_isolation"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "read committed"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-528" {
  name      = "transaction_read_only"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-529" {
  name      = "transform_null_equals"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-530" {
  name      = "unix_socket_directories"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "/tmp,/tmp/tuning_sockets"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-531" {
  name      = "unix_socket_group"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-532" {
  name      = "unix_socket_permissions"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0777"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-533" {
  name      = "update_process_title"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-534" {
  name      = "vacuum_buffer_usage_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "256"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-535" {
  name      = "vacuum_cost_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "0"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-536" {
  name      = "vacuum_cost_limit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "200"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-537" {
  name      = "vacuum_cost_page_dirty"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "20"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-538" {
  name      = "vacuum_cost_page_hit"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-539" {
  name      = "vacuum_cost_page_miss"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-540" {
  name      = "vacuum_failsafe_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1600000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-541" {
  name      = "vacuum_freeze_min_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "50000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-542" {
  name      = "vacuum_freeze_table_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "150000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-543" {
  name      = "vacuum_multixact_failsafe_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "1600000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-544" {
  name      = "vacuum_multixact_freeze_min_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-545" {
  name      = "vacuum_multixact_freeze_table_age"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "150000000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-546" {
  name      = "wal_block_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "8192"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-547" {
  name      = "wal_buffers"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2048"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-548" {
  name      = "wal_compression"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-549" {
  name      = "wal_consistency_checking"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = ""
}
resource "azurerm_postgresql_flexible_server_configuration" "res-550" {
  name      = "wal_decode_buffer_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "524288"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-551" {
  name      = "wal_init_zero"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-552" {
  name      = "wal_keep_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "400"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-553" {
  name      = "wal_level"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "replica"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-554" {
  name      = "wal_log_hints"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-555" {
  name      = "wal_receiver_create_temp_slot"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-556" {
  name      = "wal_receiver_status_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "10"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-557" {
  name      = "wal_receiver_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "60000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-558" {
  name      = "wal_recycle"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "on"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-559" {
  name      = "wal_retrieve_retry_interval"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "5000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-560" {
  name      = "wal_segment_size"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "16777216"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-561" {
  name      = "wal_sender_timeout"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "60000"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-562" {
  name      = "wal_skip_threshold"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "2048"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-563" {
  name      = "wal_sync_method"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "fdatasync"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-564" {
  name      = "wal_writer_delay"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "200"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-565" {
  name      = "wal_writer_flush_after"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "128"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-566" {
  name      = "work_mem"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "4096"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-567" {
  name      = "xmlbinary"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "base64"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-568" {
  name      = "xmloption"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "content"
}
resource "azurerm_postgresql_flexible_server_configuration" "res-569" {
  name      = "zero_damaged_pages"
  server_id = azurerm_postgresql_flexible_server.res-13.id
  value     = "off"
}
resource "azurerm_postgresql_flexible_server_database" "res-571" {
  name      = "azure_maintenance"
  server_id = azurerm_postgresql_flexible_server.res-13.id
}
resource "azurerm_postgresql_flexible_server_database" "res-572" {
  name      = "azure_sys"
  server_id = azurerm_postgresql_flexible_server.res-13.id
}
resource "azurerm_postgresql_flexible_server_database" "res-573" {
  name      = "flexibleserverdb"
  server_id = azurerm_postgresql_flexible_server.res-13.id
}
resource "azurerm_postgresql_flexible_server_database" "res-574" {
  name      = "postgres"
  server_id = azurerm_postgresql_flexible_server.res-13.id
}