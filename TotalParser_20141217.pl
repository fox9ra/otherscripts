#!/usr/bin/perl 
use strict;
use warnings;
no strict 'refs';

use Getopt::Long;
use Data::Dumper;

our @HEA_format;
our @TRAIL_format;
our @MOC_format;
our @MTC_format;
our @FORW_format;
our @ROAM_format;
our @SUPS_format;
our @HLRI_format;
our @LOCA_format;
our @SMMO_format;
our @SMMT_format;
our @POC_format;
our @PTC_format;
our @PBXO_format;
our @PBXT_format;
our @IN1_format;
our @UCA_format;
our @IN2_format;
our @IN3_format;
our @DOC_format;
our @RCC_format;
our @SMMF_format;
our @COC_format;
our @CTC_format;
our @IN4_format;
our @IN5_format;

my %FormatNameById;

$FormatNameById{"00"} = "HEA_format";
$FormatNameById{"01"} = "MOC_format";
$FormatNameById{"02"} = "MTC_format";
$FormatNameById{"03"} = "FORW_format";
$FormatNameById{"04"} = "ROAM_format";
$FormatNameById{"05"} = "SUPS_format";
$FormatNameById{"07"} = "LOCA_format";
$FormatNameById{"08"} = "SMMO_format";
$FormatNameById{"09"} = "SMMT_format";
$FormatNameById{"10"} = "TRAIL_format";
$FormatNameById{"11"} = "POC_format";
$FormatNameById{"12"} = "PTC_format";
$FormatNameById{"13"} = "PBXO_format";
$FormatNameById{"14"} = "PBXT_format";
$FormatNameById{"16"} = "IN1_format";
$FormatNameById{"17"} = "UCA_format";
$FormatNameById{"18"} = "IN2_format";
$FormatNameById{"19"} = "IN3_format";
$FormatNameById{"20"} = "DOC_format";
$FormatNameById{"22"} = "RCC_format";
$FormatNameById{"23"} = "SMMF_format";
$FormatNameById{"24"} = "COC_format";
$FormatNameById{"25"} = "CTC_format";
$FormatNameById{"26"} = "IN4_format";
$FormatNameById{"28"} = "IN5_format";

#Describe format [name] -> [length]
$HEA_format[0] = [2, "record_length", "DECIMAL"];
$HEA_format[1] = [1, "record_type", "BCD"];
$HEA_format[2] = [1, "charging_block_size", "HEX"];
$HEA_format[3] = [2, "tape_block_type", "HEX"];
$HEA_format[4] = [2, "data_length_in_block", "HEX"];
$HEA_format[5] = [10, "exchange_id", "BCD_SWAP"];
$HEA_format[6] = [4, "first_record_number", "BCD"];
$HEA_format[7] = [4, "batch_seq_number", "BCD"];
$HEA_format[8] = [2, "block_seq_number", "BCD"];
$HEA_format[9] = [7, "start_time", "TIME"];
$HEA_format[10] = [6, "format_version", "FORMAT"];

$TRAIL_format[0] = [2, "record_length", "DECIMAL"];
$TRAIL_format[1] = [1, "record_type", "BCD"];
$TRAIL_format[2] = [10, "exchange_id", "BCD_SWAP"];
$TRAIL_format[3] = [7, "end_time", "TIME"];
$TRAIL_format[4] = [4, "last_record_number", "BCD"];

$MOC_format[0] = [2, "record_length", "DECIMAL"];
$MOC_format[1] = [1, "record_type", "BCD"];
$MOC_format[2] = [4, "record_number", "BCD"];
$MOC_format[3] = [1, "record_status", "HEX"];
$MOC_format[4] = [2, "check_sum", "ASIS"];
$MOC_format[5] = [5, "call_reference", "HEX"];
$MOC_format[6] = [10, "exchange_id", "BCD_SWAP"];
$MOC_format[7] = [1, "intermediate_record_number", "BCD"];
$MOC_format[8] = [8, "calling_imsi", "BCD_SWAP"];
$MOC_format[9] = [8, "calling_imei", "BCD_SWAP"];
$MOC_format[10] = [10, "calling_number", "BCD_SWAP"];
$MOC_format[11] = [1, "calling_ms_classmark", "HEX"];
$MOC_format[12] = [1, "dialled_digits_ton", "HEX"];
$MOC_format[13] = [12, "called_number", "BCD_SWAP"];
$MOC_format[14] = [12, "dialled_digits", "BCD_SWAP"];
$MOC_format[15] = [2, "calling_subs_first_lac", "DECIMAL"];
$MOC_format[16] = [2, "calling_subs_first_ci", "DECIMAL"];
$MOC_format[17] = [2, "out_circuit_group", "BCD"];
$MOC_format[18] = [1, "basic_service_type", "HEX"];
$MOC_format[19] = [1, "basic_service_code", "HEX"];
$MOC_format[20] = [1, "channel_rate_indicator", "HEX"];
$MOC_format[21] = [7, "charging_start_time", "TIME"];
$MOC_format[22] = [7, "charging_end_time", "TIME"];
$MOC_format[23] = [3, "orig_mcz_duration", "BCD"];
$MOC_format[24] = [4, "cause_for_termination", "HEX"];
$MOC_format[25] = [3, "orig_mcz_tariff_class", "BCD"];
$MOC_format[26] = [1, "called_number_ton", "HEX"];
$MOC_format[27] = [1, "calling_number_ton", "HEX"];
$MOC_format[28] = [1, "called_msrn_ton", "HEX"];
$MOC_format[29] = [12, "called_msrn", "BCD_SWAP"];
$MOC_format[30] = [1, "routing_category", "HEX"];
$MOC_format[31] = [1, "non_transparency_indicator", "HEX"];
$MOC_format[32] = [8, "camel_call_reference", "ASIS"];
$MOC_format[33] = [1, "camel_exchange_id_ton", "HEX"];
$MOC_format[34] = [9, "camel_exchange_id", "BCD_SWAP"];
$MOC_format[35] = [1, "speech_version", "HEX"];
$MOC_format[36] = [2, "calling_subs_last_lac", "DECIMAL"];
$MOC_format[37] = [2, "calling_subs_last_ci", "DECIMAL"];
$MOC_format[38] = [1, "scp_connection", "HEX"];
$MOC_format[39] = [4, "facility_usage", "FACILITY_USAGE"];
$MOC_format[40] = [10, "virtual_msc_id", "BCD_SWAP_F"];
$MOC_format[41] = [1, "virtual_msc_id_ton", "HEX"];
$MOC_format[42] = [1, "virtual_msc_id_npi", "HEX"];

$MTC_format[0] = [2, "record_length", "DECIMAL"];
$MTC_format[1] = [1, "record_type", "BCD"];
$MTC_format[2] = [4, "record_number", "BCD"];
$MTC_format[3] = [1, "record_status", "HEX"];
$MTC_format[4] = [2, "check_sum", "ASIS"];
$MTC_format[5] = [5, "call_reference", "HEX"];
$MTC_format[6] = [10, "exchange_id", "BCD_SWAP"];
$MTC_format[7] = [1, "intermediate_record_number", "BCD"];
$MTC_format[8] = [10, "calling_number", "BCD_SWAP"];
$MTC_format[9] = [8, "called_imsi", "BCD_SWAP"];
$MTC_format[10] = [8, "called_imei", "BCD_SWAP"];
$MTC_format[11] = [12, "called_number", "BCD_SWAP"];
$MTC_format[12] = [1, "called_ms_classmark", "HEX"];
$MTC_format[13] = [2, "in_circuit_group", "BCD"];
$MTC_format[14] = [2, "called_subs_first_lac", "DECIMAL"];
$MTC_format[15] = [2, "called_subs_first_ci", "DECIMAL"];
$MTC_format[16] = [1, "basic_service_type", "HEX"];
$MTC_format[17] = [1, "basic_service_code", "HEX"];
$MTC_format[18] = [1, "channel_rate_indicator", "HEX"];
$MTC_format[19] = [7, "charging_start_time", "TIME"];
$MTC_format[20] = [7, "charging_end_time", "TIME"];
$MTC_format[21] = [3, "term_mcz_duration", "BCD"];
$MTC_format[22] = [4, "cause_for_termination", "HEX"];
$MTC_format[23] = [3, "term_mcz_tariff_class", "BCD"];
$MTC_format[24] = [1, "calling_number_ton", "HEX"];
$MTC_format[25] = [1, "called_number_ton", "HEX"];
$MTC_format[26] = [1, "routing_category", "HEX"];
$MTC_format[27] = [1, "non_transparency_indicator", "HEX"];
$MTC_format[28] = [8, "camel_call_reference", "ASIS"];
$MTC_format[29] = [1, "camel_exchange_id_ton", "HEX"];
$MTC_format[30] = [9, "camel_exchange_id", "BCD_SWAP"];
$MTC_format[31] = [1, "speech_version", "HEX"];
$MTC_format[32] = [2, "called_subs_last_lac", "DECIMAL"];
$MTC_format[33] = [2, "called_subs_last_ci", "DECIMAL"];
$MTC_format[34] = [10, "virtual_msc_id", "BCD_SWAP_F"];
$MTC_format[35] = [1, "virtual_msc_id_ton", "HEX"];
$MTC_format[36] = [1, "virtual_msc_id_npi", "HEX"];

$FORW_format[0] = [2, "record_length", "DECIMAL"];
$FORW_format[1] = [1, "record_type", "BCD"];
$FORW_format[2] = [4, "record_number", "BCD"];
$FORW_format[3] = [1, "record_status", "HEX"];
$FORW_format[4] = [2, "check_sum", "ASIS"];
$FORW_format[5] = [5, "call_reference", "HEX"];
$FORW_format[6] = [10, "exchange_id", "BCD_SWAP"];
$FORW_format[7] = [1, "intermediate_record_number", "BCD"];
$FORW_format[8] = [1, "cause_for_forwarding", "HEX"];
$FORW_format[9] = [8, "forwarding_imsi", "BCD_SWAP"];
$FORW_format[10] = [8, "forwarding_imei", "BCD_SWAP"];
$FORW_format[11] = [12, "forwarding_number", "BCD_SWAP"];
$FORW_format[12] = [1, "forwarding_ms_classmark", "HEX"];
$FORW_format[13] = [12, "forwarded_to_number", "BCD_SWAP"];
$FORW_format[14] = [10, "orig_calling_number", "BCD_SWAP"];
$FORW_format[15] = [2, "in_circuit_group", "BCD"];
$FORW_format[16] = [2, "forwarding_first_lac", "DECIMAL"];
$FORW_format[17] = [2, "forwarding_first_ci", "DECIMAL"];
$FORW_format[18] = [2, "out_circuit_group", "BCD"];
$FORW_format[19] = [1, "basic_service_type", "HEX"];
$FORW_format[20] = [1, "basic_service_code", "HEX"];
$FORW_format[21] = [1, "channel_rate_indicator", "HEX"];
$FORW_format[22] = [7, "charging_start_time", "TIME"];
$FORW_format[23] = [7, "charging_end_time", "TIME"];
$FORW_format[24] = [3, "forw_mcz_duration", "BCD"];
$FORW_format[25] = [4, "cause_for_termination", "HEX"];
$FORW_format[26] = [3, "forw_mcz_tariff_class", "BCD"];
$FORW_format[27] = [1, "forwarded_to_number_ton", "HEX"];
$FORW_format[28] = [1, "forwarding_number_ton", "HEX"];
$FORW_format[29] = [1, "orig_calling_number_ton", "HEX"];
$FORW_format[30] = [1, "forwarded_to_msrn_ton", "HEX"];
$FORW_format[31] = [12, "forwarded_to_msrn", "BCD_SWAP"];
$FORW_format[32] = [1, "routing_category", "HEX"];
$FORW_format[33] = [1, "non_transparency_indicator", "HEX"];
$FORW_format[34] = [8, "camel_call_reference", "ASIS"];
$FORW_format[35] = [1, "camel_exchange_id_ton", "HEX"];
$FORW_format[36] = [9, "camel_exchange_id", "BCD_SWAP"];
$FORW_format[37] = [1, "speech_version", "HEX"];
$FORW_format[38] = [4, "facility_usage", "FACILITY_USAGE"];
$FORW_format[39] = [1, "forwarded_to_ms_classmark", "HEX"];
$FORW_format[40] = [1, "scp_connection", "HEX"];
$FORW_format[41] = [10, "virtual_msc_id", "BCD_SWAP_F"];
$FORW_format[42] = [1, "virtual_msc_id_ton", "HEX"];
$FORW_format[43] = [1, "virtual_msc_id_npi", "HEX"];

$ROAM_format[0] = [2, "record_length", "DECIMAL"];
$ROAM_format[1] = [1, "record_type", "BCD"];
$ROAM_format[2] = [4, "record_number", "BCD"];
$ROAM_format[3] = [1, "record_status", "HEX"];
$ROAM_format[4] = [2, "check_sum", "ASIS"];
$ROAM_format[5] = [5, "call_reference", "HEX"];
$ROAM_format[6] = [10, "exchange_id", "BCD_SWAP"];
$ROAM_format[7] = [1, "intermediate_record_number", "BCD"];
$ROAM_format[8] = [10, "calling_number", "BCD_SWAP"];
$ROAM_format[9] = [8, "called_imsi", "BCD_SWAP"];
$ROAM_format[10] = [12, "called_number", "BCD_SWAP"];
$ROAM_format[11] = [12, "called_msrn", "BCD_SWAP"];
$ROAM_format[12] = [2, "in_circuit_group", "HEX"];
$ROAM_format[13] = [2, "out_circuit_group", "HEX"];
$ROAM_format[14] = [1, "basic_service_type", "HEX"];
$ROAM_format[15] = [1, "basic_service_code", "HEX"];
$ROAM_format[16] = [7, "charging_start_time", "TIME"];
$ROAM_format[17] = [7, "charging_end_time", "TIME"];
$ROAM_format[18] = [3, "roam_mcz_duration", "BCD"];
$ROAM_format[19] = [4, "cause_for_termination", "HEX"];
$ROAM_format[20] = [3, "roam_mcz_tariff_class", "BCD"];
$ROAM_format[21] = [1, "calling_number_ton", "HEX"];
$ROAM_format[22] = [1, "called_number_ton", "HEX"];
$ROAM_format[23] = [1, "called_msrn_ton", "HEX"];
$ROAM_format[24] = [1, "routing_category", "HEX"];
$ROAM_format[25] = [8, "camel_call_reference", "ASIS"];
$ROAM_format[26] = [1, "camel_exchange_id_ton", "HEX"];
$ROAM_format[27] = [9, "camel_exchange_id", "BCD_SWAP"];

$SUPS_format[0] = [2, "record_length", "DECIMAL"];
$SUPS_format[1] = [1, "record_type", "BCD"];
$SUPS_format[2] = [4, "record_number", "BCD"];
$SUPS_format[3] = [1, "record_status", "HEX"];
$SUPS_format[4] = [2, "check_sum", "ASIS"];
$SUPS_format[5] = [5, "call_reference", "HEX"];
$SUPS_format[6] = [10, "exchange_id", "BCD_SWAP"];
$SUPS_format[7] = [8, "served_imsi", "BCD_SWAP"];
$SUPS_format[8] = [8, "served_imei", "BCD_SWAP"];
$SUPS_format[9] = [10, "served_number", "BCD_SWAP"];
$SUPS_format[10] = [12, "called_number", "BCD_SWAP"];
$SUPS_format[11] = [2, "served_subs_lac", "DECIMAL"];
$SUPS_format[12] = [2, "served_subs_ci", "DECIMAL"];
$SUPS_format[13] = [1, "supplementary_service_code", "HEX"];
$SUPS_format[14] = [1, "action", "HEX"];
$SUPS_format[15] = [7, "charging_time", "TIME"];
$SUPS_format[16] = [4, "cause_for_termination", "HEX"];
$SUPS_format[17] = [1, "served_number_ton", "HEX"];
$SUPS_format[18] = [1, "called_number_ton", "HEX"];
$SUPS_format[19] = [1, "routing_category", "HEX"];
$SUPS_format[20] = [1, "served_ms_classmark", "HEX"];
$SUPS_format[21] = [1, "basic_service_type", "HEX"];
$SUPS_format[22] = [1, "basic_service_code", "HEX"];
$SUPS_format[23] = [8, "camel_call_reference", "ASIS"];
$SUPS_format[24] = [1, "camel_exchange_id_ton", "HEX"];
$SUPS_format[25] = [9, "camel_exchange_id", "BCD_SWAP"];

$HLRI_format[0] = [2, "record_length", "DECIMAL"];
$HLRI_format[1] = [1, "record_type", "BCD"];
$HLRI_format[2] = [4, "record_number", "BCD"];
$HLRI_format[3] = [1, "record_status", "HEX"];
$HLRI_format[4] = [2, "check_sum", "ASIS"];
$HLRI_format[5] = [5, "call_reference", "HEX"];
$HLRI_format[6] = [8, "called_imsi", "BCD_SWAP"];
$HLRI_format[7] = [10, "called_number", "BCD_SWAP"];
$HLRI_format[8] = [12, "routing_number", "BCD_SWAP"];
$HLRI_format[9] = [7, "charging_time", "TIME"];
$HLRI_format[10] = [1, "number_of_forwardings", "HEX"];
$HLRI_format[11] = [4, "cause_for_termination", "HEX"];

$LOCA_format[0] = [2, "record_length", "DECIMAL"];
$LOCA_format[1] = [1, "record_type", "BCD"];
$LOCA_format[2] = [4, "record_number", "BCD"];
$LOCA_format[3] = [1, "record_status", "HEX"];
$LOCA_format[4] = [2, "check_sum", "ASIS"];
$LOCA_format[5] = [5, "call_reference", "HEX"];
$LOCA_format[6] = [8, "served_imsi", "BCD_SWAP"];
$LOCA_format[7] = [2, "subs_old_lac", "DECIMAL"];
$LOCA_format[8] = [10, "subs_old_ex_id", "BCD_SWAP"];
$LOCA_format[9] = [2, "subs_new_lac", "DECIMAL"];
$LOCA_format[10] = [10, "subs_new_ex_id", "BCD_SWAP"];
$LOCA_format[11] = [7, "charging_time", "TIME"];
$LOCA_format[12] = [1, "served_number_ton", "HEX"];
$LOCA_format[13] = [12, "served_number", "BCD_SWAP"];
$LOCA_format[14] = [1, "loc_up_indicator", "HEX"];

$SMMO_format[0] = [2, "record_length", "DECIMAL"];
$SMMO_format[1] = [1, "record_type", "BCD"];
$SMMO_format[2] = [4, "record_number", "BCD"];
$SMMO_format[3] = [1, "record_status", "HEX"];
$SMMO_format[4] = [2, "check_sum", "ASIS"];
$SMMO_format[5] = [5, "call_reference", "HEX"];
$SMMO_format[6] = [10, "exchange_id", "BCD_SWAP"];
$SMMO_format[7] = [8, "calling_imsi", "BCD_SWAP"];
$SMMO_format[8] = [8, "calling_imei", "BCD_SWAP"];
$SMMO_format[9] = [10, "calling_number", "BCD_SWAP"];
$SMMO_format[10] = [1, "calling_ms_classmark", "HEX"];
$SMMO_format[11] = [12, "dialled_digits", "BCD_SWAP"];
$SMMO_format[12] = [10, "sms_centre", "BCD_SWAP"];
$SMMO_format[13] = [2, "calling_subs_lac", "DECIMAL"];
$SMMO_format[14] = [2, "calling_subs_ci", "DECIMAL"];
$SMMO_format[15] = [7, "incoming_time", "TIME"];
$SMMO_format[16] = [4, "cause_for_termination", "HEX"];
$SMMO_format[17] = [1, "basic_service_type", "HEX"];
$SMMO_format[18] = [1, "basic_service_code", "HEX"];
$SMMO_format[19] = [1, "msc_type", "HEX"];
$SMMO_format[20] = [12, "called_number", "BCD_SWAP"];
$SMMO_format[21] = [1, "calling_number_ton", "HEX"];
$SMMO_format[22] = [1, "called_number_ton", "HEX"];
$SMMO_format[23] = [2, "served_subs_ci_ext", "DECIMAL"];

$SMMT_format[0] = [2, "record_length", "DECIMAL"];
$SMMT_format[1] = [1, "record_type", "BCD"];
$SMMT_format[2] = [4, "record_number", "BCD"];
$SMMT_format[3] = [1, "record_status", "HEX"];
$SMMT_format[4] = [2, "check_sum", "ASIS"];
$SMMT_format[5] = [5, "call_reference", "HEX"];
$SMMT_format[6] = [10, "exchange_id", "BCD_SWAP"];
$SMMT_format[7] = [8, "called_imsi", "BCD_SWAP"];
$SMMT_format[8] = [8, "called_imei", "BCD_SWAP"];
$SMMT_format[9] = [12, "called_number", "BCD_SWAP"];
$SMMT_format[10] = [1, "called_ms_classmark", "HEX"];
$SMMT_format[11] = [2, "called_subs_lac", "DECIMAL"];
$SMMT_format[12] = [2, "called_subs_ci", "DECIMAL"];
$SMMT_format[13] = [10, "sms_centre", "BCD_SWAP"];
$SMMT_format[14] = [7, "incoming_time", "TIME"];
$SMMT_format[15] = [7, "delivery_time", "TIME"];
$SMMT_format[16] = [4, "cause_for_termination", "HEX"];
$SMMT_format[17] = [1, "basic_service_type", "HEX"];
$SMMT_format[18] = [1, "basic_service_code", "HEX"];
$SMMT_format[19] = [1, "msc_type", "HEX"];
$SMMT_format[20] = [11, "calling_number", "BCD_SWAP"];
$SMMT_format[21] = [1, "calling_number_ton", "HEX"];
$SMMT_format[22] = [1, "called_number_ton", "HEX"];
$SMMT_format[23] = [2, "served_subs_ci_ext", "DECIMAL"];

$POC_format[0] = [2, "record_length", "DECIMAL"];
$POC_format[1] = [1, "record_type", "BCD"];
$POC_format[2] = [4, "record_number", "BCD"];
$POC_format[3] = [1, "record_status", "HEX"];
$POC_format[4] = [2, "check_sum", "ASIS"];
$POC_format[5] = [5, "call_reference", "HEX"];
$POC_format[6] = [1, "intermediate_record_number", "BCD"];
$POC_format[7] = [1, "calling_number_ton", "HEX"];
$POC_format[8] = [12, "calling_number", "BCD_SWAP"];
$POC_format[9] = [1, "called_number_ton", "HEX"];
$POC_format[10] = [12, "called_number", "BCD_SWAP"];
$POC_format[11] = [2, "in_circuit_group", "BCD"];
$POC_format[12] = [7, "charging_start_time", "TIME"];
$POC_format[13] = [7, "charging_end_time", "TIME"];
$POC_format[14] = [4, "cause_for_termination", "HEX"];
$POC_format[15] = [3, "iaz_duration", "BCD"];
$POC_format[16] = [3, "iaz_tariff_class", "BCD"];
$POC_format[17] = [1, "called_msrn_ton", "HEX"];
$POC_format[18] = [12, "called_msrn", "BCD_SWAP"];

$PTC_format[0] = [2, "record_length", "DECIMAL"];
$PTC_format[1] = [1, "record_type", "BCD"];
$PTC_format[2] = [4, "record_number", "BCD"];
$PTC_format[3] = [1, "record_status", "HEX"];
$PTC_format[4] = [2, "check_sum", "ASIS"];
$PTC_format[5] = [5, "call_reference", "HEX"];
$PTC_format[6] = [1, "intermediate_record_number", "BCD"];
$PTC_format[7] = [1, "calling_number_ton", "HEX"];
$PTC_format[8] = [12, "calling_number", "BCD_SWAP"];
$PTC_format[9] = [1, "called_number_ton", "HEX"];
$PTC_format[10] = [12, "called_number", "BCD_SWAP"];
$PTC_format[11] = [2, "out_circuit_group", "BCD"];
$PTC_format[12] = [7, "charging_start_time", "TIME"];
$PTC_format[13] = [7, "charging_end_time", "TIME"];
$PTC_format[14] = [4, "cause_for_termination", "HEX"];
$PTC_format[15] = [3, "oaz_duration", "BCD"];
$PTC_format[16] = [3, "oaz_tariff_class", "BCD"];
$PTC_format[17] = [1, "called_msrn_ton", "HEX"];
$PTC_format[18] = [12, "called_msrn", "BCD_SWAP"];

$PBXO_format[0] = [2, "record_length", "DECIMAL"];
$PBXO_format[1] = [1, "record_type", "BCD"];
$PBXO_format[2] = [4, "record_number", "BCD"];
$PBXO_format[3] = [1, "record_status", "HEX"];
$PBXO_format[4] = [2, "check_sum", "ASIS"];
$PBXO_format[5] = [5, "call_reference", "HEX"];
$PBXO_format[6] = [1, "intermediate_record_number", "BCD"];
$PBXO_format[7] = [1, "calling_number_ton", "HEX"];
$PBXO_format[8] = [12, "calling_number", "BCD_SWAP"];
$PBXO_format[9] = [1, "called_number_ton", "HEX"];
$PBXO_format[10] = [12, "called_number", "BCD_SWAP"];
$PBXO_format[11] = [2, "in_circuit_group", "BCD"];
$PBXO_format[12] = [7, "charging_start_time", "TIME"];
$PBXO_format[13] = [7, "charging_end_time", "TIME"];
$PBXO_format[14] = [4, "cause_for_termination", "HEX"];
$PBXO_format[15] = [3, "iaz_duration", "BCD"];
$PBXO_format[16] = [3, "iaz_tariff_class", "BCD"];
$PBXO_format[17] = [1, "called_msrn_ton", "HEX"];
$PBXO_format[18] = [12, "called_msrn", "BCD_SWAP"];

$PBXT_format[0] = [2, "record_length", "DECIMAL"];
$PBXT_format[1] = [1, "record_type", "BCD"];
$PBXT_format[2] = [4, "record_number", "BCD"];
$PBXT_format[3] = [1, "record_status", "HEX"];
$PBXT_format[4] = [2, "check_sum", "ASIS"];
$PBXT_format[5] = [5, "call_reference", "HEX"];
$PBXT_format[6] = [1, "intermediate_record_number", "BCD"];
$PBXT_format[7] = [1, "calling_number_ton", "HEX"];
$PBXT_format[8] = [12, "calling_number", "BCD_SWAP"];
$PBXT_format[9] = [1, "called_number_ton", "HEX"];
$PBXT_format[10] = [12, "called_number", "BCD_SWAP"];
$PBXT_format[11] = [2, "out_circuit_group", "BCD"];
$PBXT_format[12] = [7, "charging_start_time", "TIME"];
$PBXT_format[13] = [7, "charging_end_time", "TIME"];
$PBXT_format[14] = [4, "cause_for_termination", "HEX"];
$PBXT_format[15] = [3, "oaz_duration", "BCD"];
$PBXT_format[16] = [3, "oaz_tariff_class", "BCD"];

$IN1_format[0] = [2, "record_length", "DECIMAL"];
$IN1_format[1] = [1, "record_type", "BCD"];
$IN1_format[2] = [4, "record_number", "BCD"];
$IN1_format[3] = [1, "record_status", "HEX"];
$IN1_format[4] = [2, "check_sum", "ASIS"];
$IN1_format[5] = [5, "call_reference", "HEX"];
$IN1_format[6] = [1, "in_record_number", "BCD"];
$IN1_format[7] = [61, "in_data", "ASIS"];
$IN1_format[8] = [7, "in_channel_allocated_time", "TIME"];
$IN1_format[9] = [2, "in_data_length", "DECIMAL"];

$UCA_format[0] = [2, "record_length", "DECIMAL"];
$UCA_format[1] = [1, "record_type", "BCD"];
$UCA_format[2] = [4, "record_number", "BCD"];
$UCA_format[3] = [1, "record_status", "HEX"];
$UCA_format[4] = [2, "check_sum", "ASIS"];
$UCA_format[5] = [5, "call_reference", "HEX"];
$UCA_format[6] = [10, "exchange_id", "BCD_SWAP"];
$UCA_format[7] = [1, "intermediate_record_number", "BCD_SWAP"];
$UCA_format[8] = [1, "intermediate_charging_ind", "HEX"];
$UCA_format[9] = [1, "number_of_ss_records", "BCD"];
$UCA_format[10] = [1, "calling_number_ton", "HEX"];
$UCA_format[11] = [10, "calling_number", "BCD_SWAP"];
$UCA_format[12] = [1, "called_number_ton", "HEX"];
$UCA_format[13] = [12, "called_number", "BCD_SWAP"];
$UCA_format[14] = [7, "start_time", "TIME"];
$UCA_format[15] = [4, "cause_for_termination", "HEX"];
$UCA_format[16] = [2, "in_circuit_group", "BCD"];
$UCA_format[17] = [2, "out_circuit_group", "BCD"];

$IN2_format[0] = [2, "record_length", "DECIMAL"];
$IN2_format[1] = [1, "record_type", "BCD"];
$IN2_format[2] = [4, "record_number", "BCD"];
$IN2_format[3] = [1, "record_status", "HEX"];
$IN2_format[4] = [2, "check_sum", "ASIS"];
$IN2_format[5] = [5, "call_reference", "HEX"];
$IN2_format[6] = [1, "in_record_number", "BCD"];
$IN2_format[7] = [17, "in_data", "ASIS"];
$IN2_format[8] = [7, "in_channel_allocated_time", "TIME"];
$IN2_format[9] = [2, "in_data_length", "DECIMAL"];

$IN3_format[0] = [2, "record_length", "DECIMAL"];
$IN3_format[1] = [1, "record_type", "BCD"];
$IN3_format[2] = [4, "record_number", "BCD"];
$IN3_format[3] = [1, "record_status", "HEX"];
$IN3_format[4] = [2, "check_sum", "ASIS"];
$IN3_format[5] = [5, "call_reference", "HEX"];
$IN3_format[6] = [1, "in_record_number", "BCD"];
$IN3_format[7] = [310, "in_data", "ASIS"];
$IN3_format[8] = [7, "in_channel_allocated_time", "TIME"];
$IN3_format[9] = [2, "in_data_length", "DECIMAL"];

$DOC_format[0] = [2, "record_length", "DECIMAL"];
$DOC_format[1] = [1, "record_type", "BCD"];
$DOC_format[2] = [4, "record_number", "BCD"];
$DOC_format[3] = [1, "record_status", "HEX"];
$DOC_format[4] = [2, "check_sum", "ASIS"];
$DOC_format[5] = [5, "call_reference", "HEX"];
$DOC_format[6] = [1, "intermediate_record_number", "BCD"];
$DOC_format[7] = [1, "calling_number_ton", "HEX"];
$DOC_format[8] = [12, "calling_number", "BCD_SWAP"];
$DOC_format[9] = [1, "called_number_ton", "HEX"];
$DOC_format[10] = [12, "called_number", "BCD_SWAP"];
$DOC_format[11] = [7, "charging_start_time", "TIME"];
$DOC_format[12] = [7, "charging_end_time", "TIME"];
$DOC_format[13] = [3, "orig_mcz_duration", "BCD"];
$DOC_format[14] = [3, "orig_mcz_tariff_class", "BCD"];
$DOC_format[15] = [4, "cause_for_termination", "HEX"];

$RCC_format[0] = [2, "record_length", "DECIMAL"];
$RCC_format[1] = [1, "record_type", "BCD"];
$RCC_format[2] = [4, "record_number", "BCD"];
$RCC_format[3] = [1, "record_status", "HEX"];
$RCC_format[4] = [2, "check_sum", "ASIS"];
$RCC_format[5] = [5, "call_reference", "HEX"];
$RCC_format[6] = [1, "intermediate_record_number", "BCD"];
$RCC_format[7] = [12, "dialled_digits", "BCD_SWAP"];
$RCC_format[8] = [1, "calling_number_ton", "HEX"];
$RCC_format[9] = [10, "calling_number", "BCD_SWAP"];
$RCC_format[10] = [1, "called_number_ton", "HEX"];
$RCC_format[11] = [12, "called_number", "BCD_SWAP"];
$RCC_format[12] = [2, "in_circuit_group", "BCD"];
$RCC_format[13] = [2, "out_circuit_group", "BCD"];
$RCC_format[14] = [1, "basic_service_type", "HEX"];
$RCC_format[15] = [1, "basic_service_code", "HEX"];
$RCC_format[16] = [7, "charging_start_time", "TIME"];
$RCC_format[17] = [7, "charging_end_time", "TIME"];
$RCC_format[18] = [3, "orig_mcz_tariff_class", "BCD"];
$RCC_format[19] = [1, "orig_mcz_change_percent", "BCD"];
$RCC_format[20] = [1, "orig_mcz_change_direction", "BCD"];
$RCC_format[21] = [1, "dialled_digits_ton", "HEX"];
$RCC_format[22] = [1, "called_ms_classmark", "HEX"];
$RCC_format[23] = [8, "called_imsi", "BCD_SWAP"];
$RCC_format[24] = [8, "called_imei", "BCD_SWAP"];

$SMMF_format[0] = [2, "record_length", "DECIMAL"];
$SMMF_format[1] = [1, "record_type", "BCD"];
$SMMF_format[2] = [4, "record_number", "BCD"];
$SMMF_format[3] = [1, "record_status", "HEX"];
$SMMF_format[4] = [2, "check_sum", "ASIS"];
$SMMF_format[5] = [5, "call_reference", "HEX"];
$SMMF_format[6] = [8, "called_imsi", "BCD_SWAP"];
$SMMF_format[7] = [8, "called_imei", "BCD_SWAP"];
$SMMF_format[8] = [12, "called_number", "BCD_SWAP"];
$SMMF_format[9] = [10, "sms_centre", "BCD_SWAP"];
$SMMF_format[10] = [7, "incoming_time", "TIME"];
$SMMF_format[11] = [7, "delivery_time", "TIME"];
$SMMF_format[12] = [4, "cause_for_termination", "HEX"];
$SMMF_format[13] = [1, "basic_service_type", "HEX"];
$SMMF_format[14] = [1, "basic_service_code", "HEX"];
$SMMF_format[15] = [1, "msc_type", "HEX"];
$SMMF_format[16] = [11, "calling_number", "BCD_SWAP"];
$SMMF_format[17] = [1, "calling_number_ton", "HEX"];
$SMMF_format[18] = [1, "called_number_ton", "HEX"];
$SMMF_format[19] = [1, "forwarded_to_number_ton", "HEX"];
$SMMF_format[20] = [12, "forwarded_to_number", "BCD_SWAP"];
$SMMF_format[21] = [12, "forwarded_to_smsc", "BCD_SWAP"];

$COC_format[0] = [2, "record_length", "DECIMAL"];
$COC_format[1] = [1, "record_type", "BCD"];
$COC_format[2] = [4, "record_number", "BCD"];
$COC_format[3] = [1, "record_status", "HEX"];
$COC_format[4] = [2, "check_sum", "ASIS"];
$COC_format[5] = [5, "call_reference", "HEX"];
$COC_format[6] = [10, "exchange_id", "BCD_SWAP"];
$COC_format[7] = [1, "intermediate_record_number", "BCD"];
$COC_format[8] = [7, "in_channel_allocated_time", "TIME"];
$COC_format[9] = [8, "camel_call_reference", "ASIS"];
$COC_format[10] = [7, "charging_start_time", "TIME"];
$COC_format[11] = [7, "charging_end_time", "TIME"];
$COC_format[12] = [3, "duration_before_answer", "BCD"];
$COC_format[13] = [3, "chargeable_duration", "BCD"];
$COC_format[14] = [1, "basic_call_state_model", "HEX"];
$COC_format[15] = [4, "camel_service_key", "HEX"];
$COC_format[16] = [1, "destination_number_ton", "HEX"];
$COC_format[17] = [12, "destination_number", "BCD_SWAP"];
$COC_format[18] = [1, "level_of_camel_service", "HEX"];
$COC_format[19] = [4, "camel_modification", "HEX"];
$COC_format[20] = [1, "camel_exchange_id_ton", "HEX"];
$COC_format[21] = [9, "camel_exchange_id", "BCD_SWAP"];
$COC_format[22] = [9, "scf_address", "BCD_SWAP"];
$COC_format[23] = [1, "scf_address_ton", "HEX"];
$COC_format[24] = [1, "default_call_handling", "HEX"];
$COC_format[25] = [1, "destination_number_npi", "HEX"];

$CTC_format[0] = [2, "record_length", "DECIMAL"];
$CTC_format[1] = [1, "record_type", "BCD"];
$CTC_format[2] = [4, "record_number", "BCD"];
$CTC_format[3] = [1, "record_status", "HEX"];
$CTC_format[4] = [2, "check_sum", "ASIS"];
$CTC_format[5] = [5, "call_reference", "HEX"];
$CTC_format[6] = [1, "intermediate_record_number", "BCD"];
$CTC_format[7] = [7, "in_channel_allocated_time", "TIME"];
$CTC_format[8] = [8, "camel_call_reference", "ASIS"];
$CTC_format[9] = [3, "duration_before_answer", "BCD"];
$CTC_format[10] = [7, "charging_start_time", "TIME"];
$CTC_format[11] = [7, "charging_end_time", "TIME"];
$CTC_format[12] = [3, "chargeable_duration", "BCD"];
$CTC_format[13] = [1, "basic_call_state_model", "HEX"];
$CTC_format[14] = [4, "camel_service_key", "HEX"];
$CTC_format[15] = [1, "destination_number_ton", "HEX"];
$CTC_format[16] = [12, "destination_number", "BCD_SWAP"];
$CTC_format[17] = [1, "level_of_camel_service", "HEX"];
$CTC_format[18] = [4, "camel_modification", "HEX"];
$CTC_format[19] = [1, "camel_exchange_id_ton", "HEX"];
$CTC_format[20] = [9, "camel_exchange_id", "BCD_SWAP"];
$CTC_format[21] = [9, "scf_address", "BCD_SWAP"];
$CTC_format[22] = [1, "scf_address_ton", "HEX"];
$CTC_format[23] = [1, "default_call_handling", "HEX"];
$CTC_format[24] = [1, "destination_number_npi", "HEX"];

$IN4_format[0] = [2, "record_length", "DECIMAL"];
$IN4_format[1] = [1, "record_type", "BCD"];
$IN4_format[2] = [4, "record_number", "BCD"];
$IN4_format[3] = [1, "record_status", "HEX"];
$IN4_format[4] = [2, "check_sum", "ASIS"];
$IN4_format[5] = [5, "call_reference", "HEX"];
$IN4_format[6] = [1, "in_record_number", "BCD"];
$IN4_format[7] = [40, "in_data", "ASIS"];
$IN4_format[8] = [7, "in_channel_allocated_time", "TIME"];
$IN4_format[9] = [2, "in_data_length", "DECIMAL"];
$IN4_format[10] = [8, "camel_call_reference", "ASIS"];
$IN4_format[11] = [1, "basic_call_state_model", "HEX"];
$IN4_format[12] = [1, "party_to_charge", "HEX"];
$IN4_format[13] = [1, "camel_exchange_id_ton", "HEX"];
$IN4_format[14] = [9, "camel_exchange_id", "BCD_SWAP"];

$IN5_format[0] = [2, "record_length", "DECIMAL"];
$IN5_format[1] = [1, "record_type", "BCD"];
$IN5_format[2] = [4, "record_number", "BCD"];
$IN5_format[3] = [1, "record_status", "HEX"];
$IN5_format[4] = [2, "check_sum", "ASIS"];
$IN5_format[5] = [5, "call_reference", "HEX"];
$IN5_format[6] = [1, "in_record_number", "BCD"];
$IN5_format[7] = [160, "in_data", "ASIS"];
$IN5_format[8] = [7, "in_channel_allocated_time", "TIME"];
$IN5_format[9] = [2, "in_data_length", "DECIMAL"];
$IN5_format[10] = [8, "camel_call_reference", "ASIS"];
$IN5_format[11] = [1, "basic_call_state_model", "HEX"];
$IN5_format[12] = [1, "party_to_charge", "HEX"];
$IN5_format[13] = [1, "camel_exchange_id_ton", "HEX"];
$IN5_format[14] = [9, "camel_exchange_id", "BCD_SWAP"];

#additional digest
my %action_digest;
my %bcsm_digest;
my %bc_code_digest;
my %tele_service_digest;
my %bearer_service_digest;

$action_digest{"00"} = "registration";
$action_digest{"01"} = "erasure";
$action_digest{"02"} = "activation";
$action_digest{"03"} = "deactivation";
$action_digest{"04"} = "interrogation";
$action_digest{"05"} = "invocation";
$action_digest{"06"} = "password registration";
$action_digest{"07"} = "phase 1 USSD";
$action_digest{"08"} = "phase 2 USSD request";
$action_digest{"09"} = "phase 2 USSD notify";

$bcsm_digest{"00"} = "Type of basic call state model not defined";
$bcsm_digest{"01"} = "Basic call state model for originating side";
$bcsm_digest{"02"} = "Basic call state model for terminating side";
$bcsm_digest{"03"} = "Originating SMS state model";
$bcsm_digest{"04"} = "Basic call state model for terminating gateway MSC";
$bcsm_digest{"05"} = "Originating basic call state model for call forwarding";
$bcsm_digest{"06"} = "Originating side for COBI call";
$bcsm_digest{"07"} = "Terminating side for COBI call";

$bc_code_digest{"00"} = "Teleservice";
$bc_code_digest{"01"} = "Bearer service";

$tele_service_digest{"00"} = "All teleservices";
$tele_service_digest{"10"} = "Speech transmission";
$tele_service_digest{"11"} = "Telephony";
$tele_service_digest{"12"} = "Emergency calls";
$tele_service_digest{"20"} = "Short messages services";
$tele_service_digest{"21"} = "Short message MT/PP";
$tele_service_digest{"22"} = "Short message MO/PP";
$tele_service_digest{"30"} = "Data MHS";
$tele_service_digest{"31"} = "Advanced MHS access";
$tele_service_digest{"40"} = "Videotex access services";
$tele_service_digest{"41"} = "Videotex access profile 1";
$tele_service_digest{"42"} = "Videotex access profile 2";
$tele_service_digest{"43"} = "Videotex access profile 3";
$tele_service_digest{"50"} = "Teletex service";
$tele_service_digest{"51"} = "Teletex CS";
$tele_service_digest{"52"} = "Teletex PS";
$tele_service_digest{"60"} = "Facsimile";
$tele_service_digest{"61"} = "Facsimile Group 3 and alter speech";
$tele_service_digest{"62"} = "Automatic facsimile Group 3";
$tele_service_digest{"63"} = "Automatic facsimile Group 4";
$tele_service_digest{"70"} = "All data teleservices (compound)";
$tele_service_digest{"80"} = "All teleservices expect SMS (compound)";
$tele_service_digest{"d1"} = "Dual numbering (alternate line service)";

$bearer_service_digest{"00"} = "All bearer services";
$bearer_service_digest{"10"} = "3.1 kHz group";
$bearer_service_digest{"11"} = "3.1 kHz ex PLMN";
$bearer_service_digest{"12"} = "alternate/speech";
$bearer_service_digest{"13"} = "speech followed by 3.1 kHz";
$bearer_service_digest{"20"} = "Data c.d.a";
$bearer_service_digest{"21"} = "Data c.d.a 300 b/s";
$bearer_service_digest{"22"} = "Data c.d.a 1200 b/s";
$bearer_service_digest{"23"} = "Data c.d.a 1200-75 b/s";
$bearer_service_digest{"24"} = "Data c.d.a 2400 b/s";
$bearer_service_digest{"25"} = "Data c.d.a 4800 b/s";
$bearer_service_digest{"26"} = "Data c.d.a 9600 b/s";
$bearer_service_digest{"27"} = "Data c.d.a general";
$bearer_service_digest{"30"} = "Data c.d.s";
$bearer_service_digest{"32"} = "Data c.d.s 1200 b/s";
$bearer_service_digest{"34"} = "Data c.d.s 2400 b/s";
$bearer_service_digest{"35"} = "Data c.d.s 4800 b/s";
$bearer_service_digest{"36"} = "Data c.d.s 9600 b/s";
$bearer_service_digest{"37"} = "Data c.d.s general";
$bearer_service_digest{"40"} = "PAD access c.d.a";
$bearer_service_digest{"41"} = "PAD access c.d.a 300 b/s";
$bearer_service_digest{"42"} = "PAD access c.d.a 1200 b/s";
$bearer_service_digest{"43"} = "PAD access c.d.a 1200-75 b/s";
$bearer_service_digest{"44"} = "PAD access c.d.a 2400 b/s";
$bearer_service_digest{"45"} = "PAD access c.d.a 4800 b/s";
$bearer_service_digest{"46"} = "PAD access c.d.a 9600 b/s";
$bearer_service_digest{"47"} = "PAD access c.d.a general";
$bearer_service_digest{"50"} = "Data p.d.s";
$bearer_service_digest{"54"} = "Data p.d.s 2400 b/s";
$bearer_service_digest{"55"} = "Data p.d.s 4800 b/s";
$bearer_service_digest{"56"} = "Data p.d.s 9600 b/s";
$bearer_service_digest{"57"} = "Data p.d.s general";
$bearer_service_digest{"60"} = "Alternate speech/data c.d.a";
$bearer_service_digest{"70"} = "Alternate speech/ data c.d.s";
$bearer_service_digest{"80"} = "Speech followed by data c.d.a";
$bearer_service_digest{"90"} = "Speech followed by data c.d.s";

#main part
my $input_file_name;
my $output_file_name;
my $debug_output_level = 0;
my $statistics = 0;
my $parse_type = "all";
my $gluing = "";
my $extended_gluing = 0;
my $analytics = "";
my $bis = 0;
my $verbose = 0;
GetOptions ("if=s" => \$input_file_name,
            "of=s"   => \$output_file_name,
            "bis" => \$bis,
            "details=i"  => \$debug_output_level,
            "statistics" => \$statistics,
            "rtype=s" => \$parse_type,
            "gluing=s" => \$gluing,
            "eg" => \$extended_gluing,
            "analytics=s" => \$analytics,
            "verbose"  => \$verbose,
            "version" => sub { printVersion() },
            "usage|help|?" => sub { printUsage() }) or die; 
            
if (!defined($input_file_name)) {
    print "ERROR: -if parameter is not set\n";
    printUsage();
}
if (!defined($output_file_name)) {
    $output_file_name = $input_file_name . ".txt";
}

if (($extended_gluing > 0) && ($gluing eq "")) {
	print "WARNING: -eg parameter can't be used without gluing. Parameter will be ignored\n";
}

my %IdByFormatName;
while (my ($key, $value) = each (%FormatNameById)) {
    $value =~ s/_.*//;
    $IdByFormatName{$value} = $key;
}

my %gluing;
$gluing =~ tr/a-z/A-Z/; 
if ($gluing eq "COC_MOC") {
    $parse_type = "01|24";
} elsif ($gluing eq "COC_FORW") {
    $parse_type = "03|24";
} elsif ($gluing eq "IN4_MOC") {
    $parse_type = "01|26";
} elsif ($gluing eq "IN4_FORW") {
    $parse_type = "03|26";
} elsif ($gluing eq "COC_UCA") {
    $parse_type = "17|24";
}

$parse_type =~ tr/a-z/A-Z/; 
my @parse_type;    
my %parse_type;    
if ($parse_type =~ /all/i) {
    @parse_type = keys(%FormatNameById);
} else {
    @parse_type = split(/\|/, $parse_type);
}
for (my $parse_type_counter = 0; $parse_type_counter <= $#parse_type; $parse_type_counter++) {
    if ($parse_type[$parse_type_counter] !~ /^\d+$/) {
        if (defined($IdByFormatName{$parse_type[$parse_type_counter]})) {
            $parse_type[$parse_type_counter] = $IdByFormatName{$parse_type[$parse_type_counter]};
        } else {
            die "Wrong rtype parameter $parse_type[$parse_type_counter]\n";
        }
    }
}
%parse_type = map {$_ => "1"} @parse_type;

         
open(DX200_FILE, "<$input_file_name") or die "Can't open file: $!";
open(RES_FILE, ">$output_file_name") or die "Can't open file: $!";
binmode DX200_FILE;

my %statistics;
my %analytics;

my $buf;
my $buf2;
my $lead_rec_size = 3;
my $charging_block_size;

#verbose update
my $debug_offset = 0;

#extra length check
my %rectype_length;

#made for optim by asi
my @fields;
while(read(DX200_FILE, $buf, $lead_rec_size)) {
    my ($rec_length, $rec_type) = unpack("v1H2", $buf);
    if ($verbose) {
        my $decimal = hex($rec_type);
        $decimal = '0'.$decimal if ($decimal < 10);
        my $format_name = $FormatNameById{$rec_type};
        $format_name =~ s/_(.*)//;
    	print "Length: [$rec_length], RecType: [0x$rec_type][$decimal][$format_name], Offset:[$debug_offset]\n";
    }
    
    extraCheck($rec_length, $rec_type);
    $debug_offset += $rec_length;
    $statistics{$rec_type}++;
    read(DX200_FILE, $buf2, $rec_length - $lead_rec_size);
    #my @fields;
    if (($parse_type{$rec_type}) || ($rec_type eq "00")) { 
        @fields = parseRecord($rec_type, $buf.$buf2);
    }
    if ($rec_type eq "00") {
        $charging_block_size = getChargingBlockSize($fields[2]);
    }
    $charging_block_size = $charging_block_size - $rec_length;
    #skip finalizing padding
    if ($rec_type eq "10") {
        $debug_offset += $charging_block_size;
        read(DX200_FILE, $buf, $charging_block_size);
    }
    if ($parse_type{$rec_type}) { 
        #printRecord($rec_type, @fields); made for optim by asi
        printRecord($rec_type);
    }
}
#print Dumper(%analytics);
printAnalytics();
close DX200_FILE;
close RES_FILE;

if ($statistics != 0) {
    print "STATISTICS:\n";
    while (my ($type, $counter) = each(%statistics)) {
        my $format_name = $FormatNameById{$type};
        $format_name =~ s/_(.*)//;
        print "$format_name\t$counter\n";
    }
}

sub extraCheck {
    my $rec_length = shift;
    my $rec_type = shift;
    my $rec_name = $FormatNameById{$rec_type};
    if (!defined($rec_name)) {
        die "Undefined record type. Input file may be corrupted. Use verbose option for detailed output.";
    }
    my $expected_rec_length = 0;
    if (defined($rectype_length{$rec_type})) {
        $expected_rec_length = $rectype_length{$rec_type};
    } else {
        foreach my $ref (@{$rec_name}) {
            $expected_rec_length += $ref->[0];
        }
        $rectype_length{$rec_type} = $expected_rec_length;
    }
    if ($rec_length != $expected_rec_length) {
        $rec_name =~ s/_(.*)//;
        my $decimal = hex($rec_type);
        $decimal = '0'.$decimal if ($decimal < 10);
        die "Length: [$rec_length], RecType: [0x$rec_type][$decimal][$rec_name], Offset:[$debug_offset]. Record length [$rec_length] not equal to Expected record length [$expected_rec_length]. Input file may be corrupted or format version must be updated. Use verbose option for detailed output.";
    }
}

sub parseRecord {
    my $rec_type = shift(@_);
    my $buf = shift(@_);
    my $format_string = "";
    my $format_name = $FormatNameById{$rec_type};
    foreach my $ref (@{$format_name}) {
        $format_string .= "H".$ref->[0]*2;
    }
    return unpack($format_string, $buf);
}

sub printRecord {
    my $rec_type = shift(@_);
    #my @fields = @_; made for optim by asi
    my $format_name = $FormatNameById{$rec_type};
    my $superstring = "";
    if (!$bis) {
    	$superstring = "[$format_name]\n";
	}
    for (my $i = 0; $i <= $#fields; $i++) {
        #process value to human readable format
        my ($encoded_value, $original_value) = decode($format_name, $i, $fields[$i]);
        #process special situations
        if (!$bis) {
        	$encoded_value = processSpecial($format_name, $i, $encoded_value);
	        #change output detalization
	        if ($debug_output_level == 0) {
	            $original_value = "";
	        } elsif ($debug_output_level > 1) {
	            $original_value = $fields[$i];
	        }
	        $original_value = "[".$original_value."]" if $original_value ne "";
        }
        #generate output string 
        my $field_name = ${$format_name}[$i]->[1];
        if ($bis) {
        	$superstring .= $encoded_value.";";
        } else {
        	$superstring .= $field_name." = ".$encoded_value." $original_value\n";
        }
        if (($analytics ne "") and ($field_name =~ /$analytics/)) {
            $analytics{$rec_type}{$field_name}{$encoded_value}++;
        }
    }
    $superstring .= "\n";
    
    if ($gluing eq "COC_MOC") {
        my $ccr_cei = "";
        if ($rec_type eq "24") {
            $ccr_cei = "$fields[9]_$fields[21]";
            $gluing{$ccr_cei} = $superstring;
            $superstring = "";
        } elsif ($rec_type eq "01") {
            $ccr_cei = "$fields[32]_$fields[34]";
            if (defined($gluing{$ccr_cei})) {
                print RES_FILE $superstring;
                my @used_coc_fields;
                if ($extended_gluing) {
            		@used_coc_fields = (split(/\n/, $gluing{$ccr_cei}));
            	} else {
            		@used_coc_fields = (split(/\n/, $gluing{$ccr_cei}))[16, 23, 17, 18, 20];
            	}
                print RES_FILE join("\n", @used_coc_fields)."\n\n";
                delete($gluing{$ccr_cei});
                $superstring = "";
            } else {
                $superstring = "";
            }
        }
    } elsif ($gluing eq "COC_FORW") {
        my $ccr_cei = "";
        if ($rec_type eq "24") {
            $ccr_cei = "$fields[9]_$fields[21]";
            $gluing{$ccr_cei} = $superstring;
            $superstring = "";
        } elsif ($rec_type eq "03") {
            $ccr_cei = "$fields[34]_$fields[36]";
            if (defined($gluing{$ccr_cei})) {
                print RES_FILE $superstring;
                my @used_coc_fields;
                if ($extended_gluing) {
            		@used_coc_fields = (split(/\n/, $gluing{$ccr_cei}));
            	} else {
            		@used_coc_fields = (split(/\n/, $gluing{$ccr_cei}))[16, 23, 17, 18, 20];
            	}
                print RES_FILE join("\n", @used_coc_fields)."\n\n";
                delete($gluing{$ccr_cei});
                $superstring = "";
            } else {
                $superstring = "";
            }
        }
    } elsif ($gluing eq "IN4_MOC") {
        my $ccr_cei = "";
        if ($rec_type eq "26") {
            $ccr_cei = "$fields[10]_$fields[14]";
            $gluing{$ccr_cei} = $superstring;
            $superstring = "";
        } elsif ($rec_type eq "01") {
            $ccr_cei = "$fields[32]_$fields[34]";
            if (defined($gluing{$ccr_cei})) {
                print RES_FILE $superstring;
                my @used_in4_fields;
                if ($extended_gluing) {
            		@used_in4_fields = (split(/\n/, $gluing{$ccr_cei}));
            	} else {
            		@used_in4_fields = (split(/\n/, $gluing{$ccr_cei}))[8, 10];
            	}
                print RES_FILE join("\n", @used_in4_fields)."\n\n";
                delete($gluing{$ccr_cei});
                $superstring = "";
            } else {
                $superstring = "";
            }
        }
    } elsif ($gluing eq "IN4_FORW") {
        my $ccr_cei = "";
        if ($rec_type eq "26") {
            $ccr_cei = "$fields[10]_$fields[14]";
            $gluing{$ccr_cei} = $superstring;
            $superstring = "";
        } elsif ($rec_type eq "03") {
            $ccr_cei = "$fields[34]_$fields[36]";
            if (defined($gluing{$ccr_cei})) {
                print RES_FILE $superstring;
                my @used_in4_fields;
                if ($extended_gluing) {
            		@used_in4_fields = (split(/\n/, $gluing{$ccr_cei}));
            	} else {
            		@used_in4_fields = (split(/\n/, $gluing{$ccr_cei}))[8, 10];
            	}
                print RES_FILE join("\n", @used_in4_fields)."\n\n";
                #asi: maybe we should use [= ""] instead of [delete] not to allocate memory next time
                delete($gluing{$ccr_cei});
                $superstring = "";
            } else {
                $superstring = "";
            }
        }
    } elsif ($gluing eq "COC_UCA") {
        my $cr = "";
        if ($rec_type eq "24") {
            $cr = "$fields[5]";
            $gluing{$cr} = $superstring;
            $superstring = "";
        } elsif ($rec_type eq "17") {
            $cr = "$fields[5]";
            if (defined($gluing{$cr})) {
                print RES_FILE $superstring;
                my @used_in4_fields;
                if ($extended_gluing) {
            		@used_in4_fields = (split(/\n/, $gluing{$cr}));
            	} else {
            		@used_in4_fields = (split(/\n/, $gluing{$cr}))[1..18];
            	}
                print RES_FILE join("\n", @used_in4_fields)."\n\n";
                #asi: maybe we should use [= ""] instead of [delete] not to allocate memory next time
                delete($gluing{$cr});
                $superstring = "";
            } else {
                $superstring = "";
            }
        }
    }
    
    print RES_FILE $superstring;
}

sub printAnalytics {
    if ($analytics ne "") {
        print "ANALYTICS:\n";
    }
    while (my ($rec_type, $fields) = each(%analytics)) {
        my $format_name = $FormatNameById{$rec_type};
        $format_name =~ s/_.*//;
        print $format_name, "\n";
        while (my ($field, $values) = each(%$fields)) {    
            print "  ", $field, "\n";
            while (my ($value, $counter) = each(%$values)) {    
                print sprintf("    %-60.60s  %d\n", $value, $counter);
            }
        }
    }
    print "\n";
}

sub decode {
    my $format_name = shift(@_);
    my $field_index = shift(@_);
    my $field = shift(@_);
    my $encoded_value = "";
    my $original_value = "";
    my $decode_type = ${$format_name}[$field_index]->[2];
    if ($decode_type eq "BCD_SWAP") {
        $encoded_value = decodeBCD_SWAP($field);
    } elsif ($decode_type eq "DECIMAL") {
        $encoded_value = decodeDECIMAL($field);
        $original_value = $field;
    } elsif ($decode_type eq "BCD_SWAP_F") {
        $encoded_value = decodeBCD_SWAP_F($field);
    } elsif ($decode_type eq "FORMAT") {
        $encoded_value = decodeFORMAT($field);
        $original_value = $field;
    } elsif ($decode_type eq "WWB") {
        $encoded_value = decodeWWB($field);
        $original_value = $field;
    } elsif ($decode_type eq "ASIS") {
        $encoded_value = $field;
    } elsif ($decode_type eq "FACILITY_USAGE") {
    	if (!$bis) {
	        $encoded_value = decodeFU($field);
	        $original_value = $field;
	    } else {
	    	$encoded_value = $field;
	        $original_value = $field;
	    }
    } else {
        $encoded_value = decodeSWAP($field);
    }
    return $encoded_value, $original_value;
}

sub processSpecial {
    my $format_name = shift(@_);
    my $field_index = shift(@_);
    my $encoded_value = shift(@_);
    my $fields_ref = shift(@_);
    #my @fields = @$fields_ref; made for optim by asi
    my $field_name = ${$format_name}[$field_index]->[1];
    #process "ff" values as "not used"
    if (($encoded_value =~ /^[f]+$/i) || ($encoded_value eq "")) {
        $encoded_value = "NOT USED";
    }
    #if ton = 18 process number as string
    if ($field_name =~ /_number$/) {
        TON_SEARCH:
        for (my $index = 0; $index <= $#fields; $index++) {
            if (${$format_name}[$index]->[1] eq "${field_name}_ton") {
                if ($fields[$index] eq "18") {
                    my $number_as_string = "";
                    my @digits = split("", $encoded_value);
                    for (my $digit_index = 0; $digit_index < $#digits; $digit_index = $digit_index + 2) {
                        $number_as_string .= chr(hex($digits[$digit_index].$digits[$digit_index+1]));
                    }
                    $encoded_value .= " [$number_as_string]";
                }
                last TON_SEARCH;
            }
        }
    }
    #process action
    if ($field_name eq "action") {
        $encoded_value .= " [$action_digest{$encoded_value}]";
    }
    #process basic_call_state_model
    if ($field_name eq "basic_call_state_model") {
        $encoded_value .= " [$bcsm_digest{$encoded_value}]";
    }
    #process basic_service_type
    if (($field_name eq "basic_service_type") && ($encoded_value ne "NOT USED")) {
        $encoded_value .= " [$bc_code_digest{$encoded_value}]";
    }
    #process basic_service_code
    if ($field_name eq "basic_service_code") {
        if ($fields[$field_index-1] eq "00") {
            print "$encoded_value\n" if (!defined $tele_service_digest{$encoded_value});
            $encoded_value .= " [$tele_service_digest{$encoded_value}]";
        } elsif ($fields[$field_index-1] eq "01") {
            $encoded_value .= " [$bearer_service_digest{$encoded_value}]";
        }
    }
    #process duration values
    if (($field_name =~ /duration/) && ($encoded_value ne "NOT USED")) {
        $encoded_value =~ s/^[0]+//;
        $encoded_value .= " sec";
    }
    return $encoded_value;
}

#decode functions

sub decodeSWAP {
    my $encoded_string = shift(@_);
    my $length = length($encoded_string);
    return unpack("h".$length, pack("H".$length, scalar reverse ($encoded_string)));
}

sub decodeFU {
    my $encoded_string = shift(@_);
    my $decoded_string = "";
    my @digits = split("", $encoded_string);
    
    $decoded_string .= "\n\taoc_charging = ".(hex($digits[1]) & 1)."\n";
    $decoded_string .= "\taoc_charging_information_at_the_end_of_the_call = ".(hex($digits[1]) & 2)."\n";
    $decoded_string .= "\taoc_information = ".(hex($digits[1]) & 4)."\n";
    $decoded_string .= "\tcalling_line_identification_presentation = ".(hex($digits[1]) & 8)."\n";
    $decoded_string .= "\tcalling_line_identification_restriction = ".(hex($digits[0]) & 1)."\n";
    $decoded_string .= "\tcall_hold = ".(hex($digits[0]) & 2)."\n";
    $decoded_string .= "\tcall_wait = ".(hex($digits[0]) & 4)."\n";
    $decoded_string .= "\tmultiparty = ".(hex($digits[0]) & 8)."\n";
    $decoded_string .= "\tintelligent_network = ".(hex($digits[3]) & 1)."\n";
    $decoded_string .= "\tcall_transfer = ".(hex($digits[3]) & 2)."\n";
    $decoded_string .= "\tcall_transfer_recall = ".(hex($digits[3]) & 4)."\n";
    $decoded_string .= "\tcall_drop_back = ".(hex($digits[3]) & 8)."\n";
    $decoded_string .= "\tforwarding = ".(hex($digits[2]) & 1)."\n";
    $decoded_string .= "\tcall_forwarding_overdrive = ".(hex($digits[2]) & 2)."\n";
    $decoded_string .= "\tspare = ".(hex($digits[2]) & 4)."\n";
    $decoded_string .= "\tspare = ".(hex($digits[2]) & 8)."\n";
    $decoded_string .= "\tcompletion_of_calls_to_busy_subscribers = ".(hex($digits[5]) & 1)."\n";
    $decoded_string .= "\tcamel = ".(hex($digits[5]) & 2)."\n";
    $decoded_string .= "\tported_in = ".(hex($digits[5]) & 4)."\n";
    $decoded_string .= "\tconnected_line_identification_presentation = ".(hex($digits[5]) & 8)."\n";
    $decoded_string .= "\tconnected_line_identification_restriction = ".(hex($digits[4]) & 1)."\n";
    $decoded_string .= "\tuus1_origination_release_of_call = ".(hex($digits[4]) & 2)."\n";
    $decoded_string .= "\tuus2_ringing_phase = ".(hex($digits[4]) & 4)."\n";
    $decoded_string .= "\tuus3_during_connection = ".(hex($digits[4]) & 8)."\n";
    $decoded_string .= "\taoc_during_the_call = ".(hex($digits[7]) & 1)."\n";
    $decoded_string .= "\tmulticall = ".(hex($digits[7]) & 2)."\n";
    $decoded_string .= "\teMLPP = ".(hex($digits[7]) & 4)."\n";
    $decoded_string .= "\tTTY = ".(hex($digits[7]) & 8)."\n";
    $decoded_string .= "\tSINAP = ".(hex($digits[6]) & 1)."\n";
    $decoded_string .= "\tcalling_name_presentation = ".(hex($digits[6]) & 2)."\n";
    $decoded_string .= "\tspare = ".(hex($digits[6]) & 4)."\n";
    $decoded_string .= "\tspare = ".(hex($digits[6]) & 8);
    $decoded_string =~ s/[1-9]/1/g;
    
    return $decoded_string;
}

sub decodeWWB {
    my $encoded_string = shift(@_);
    my $decoded_string = "";
    my @digits = split("", $encoded_string);
    $decoded_string = $digits[2].$digits[3].$digits[0].$digits[1]." ".$digits[6].$digits[7].$digits[4].$digits[5]." ".$digits[8].$digits[9];
    return $decoded_string;
}

sub decodeFORMAT {
    my $encoded_string = shift(@_);
    my $decoded_string = "";
    my @digits = split("", $encoded_string);
    my $customer = chr(hex($digits[0].$digits[1])).chr(hex($digits[2].$digits[3]));
    my $version = $digits[4].$digits[5].".".$digits[6].$digits[7]."-".$digits[8].$digits[9];
    $version =~ s/0(\d+)/$1/g;
    $decoded_string = $customer." ".$version;
    return $decoded_string;
}

sub decodeDECIMAL {
    my $encoded_string = shift(@_);
    my $decoded_string = "";
    my @digits = split("", $encoded_string);
    for (my $octet_index = 0; $octet_index < $#digits; $octet_index = $octet_index + 2) {
        $decoded_string = $digits[$octet_index].$digits[$octet_index+1].$decoded_string;
    }
    return hex($decoded_string);
} 

sub decodeBCD_SWAP {
    my $encoded_string = shift(@_);
    my $length = length($encoded_string);
    my $decoded_string = unpack("h".$length, pack("H".$length, $encoded_string));
    $decoded_string =~ s/[f]+$//i;
    return $decoded_string;
}

sub decodeBCD_SWAP_F {
    my $encoded_string = shift(@_);
    my $length = length($encoded_string);
    my $decoded_string = unpack("h".$length, pack("H".$length, $encoded_string));
    $decoded_string =~ s/[f]+$//i;
    return $decoded_string;
}

#internal functions

sub getChargingBlockSize {
    my $charging_block_size_type = shift(@_);
    my $block_size = 0;
    if ($charging_block_size_type eq "00") {
        $block_size = 2044;
    } elsif ($charging_block_size_type eq "01") {
        $block_size = 8176;
    } elsif ($charging_block_size_type eq "02") {
        $block_size = 16352;
    } elsif ($charging_block_size_type eq "04") {
        $block_size = 32704;
    } elsif ($charging_block_size_type eq "08") {
        $block_size = 65408;
    }
    return $block_size;
}

# version
# 1.1.3 - added new teleservices types
# 1.1.2 - added verbose. Extra record length check.
# 1.1.1 - mandatory to optional fields
# 1.1.0 - added analytics functionality
#         -analytics option added
# 1.0.1 - -usage|help|? option added
#         -version option added
#         -gluing option now case insensetive
# 1.0.0 - beta release
# 0.3.1 - code review 
# 0.3.0 - profiling 
# 0.2.1 - fixed ton=18 bug
#       - added duration special processing
# 0.2.0 - added gluing functionality
#       - -gluing flag added
# 0.1.0 - added statistic functionality 
#       - -stat flag added
# 0.0.5 - added different types of output detalization
#       - -v flag added
# 0.0.4 - support of separate type processing 
#       - -rt flag added
# 0.0.3 - added digest transformation
#       - padding bug fixed
# 0.0.2 - added facility usage type
# 0.0.1 - initial draft

sub printVersion {
    my $version = <<END;
TotalParser 1.1.2 20140626
Copyright (C) 2012-2014 COMPLETE
This is utility tool for processing Nokia DX200 binary format written in Perl. TotalParser can convert binary format to human readable text representation, count statistics, make some kinds of record gluing. It may be slow when processing big files.

Print "perl TotalParser.pl -[usage|help|?]" to get information about options.

Report bugs to <ivanov\@complete.ru>.
END
    print $version;
    exit(0);
}

sub printUsage {
    my $usage = <<END;

Usage: perl TotalParser.pl -if <input_file> -of <output_file> [options]
  -if[string]       Specify input binary DX200 file. Mandatory.
  -of[string]       Specify output file name. Optional. If not set input file
  					name with .txt suffix will be used.
  -verbose			Output information about each record type, length, offset.
  -d[int]           Specify output detalization. 
                        0 - no details;
                        1 - output details for complex transformations;
                        2 - full detalization.
  -stat             Output number of records of each record type. One per line.
  -rt[string]       Specify record types for processing. By default all record 
                    types are processed. Record type may be set by it's hex 
                    representation or by name in any case. Several record types 
                    may be set separated by | symbol. Example: -rt "00|MOC|mtc"
                    will process only HEAD, MOC and MTC record types.
  -gluing[string]   Will try to glue record types set by parameter. Gluing are 
                    made by camel_call_ref and camel_excange_id. Four 
                    parameters are supported. 
                        COC_MOC - Will try to glue COC and MOC rec types;
                        COC_FORW - Will try to glue COC and FORW rec types;
                        IN4_MOC - Will try to glue IN4 and MOC rec types;
                        IN4_FORW - Will try to glue IN4 and FORW rec types;
                    You can set only one parameter for each launch. Parameters
                    are not case sensetive.
  -eg 				Extended gluing. Will output more information for second
  					rec type.
  -analyt[string]   Counts number of occurences of each value of string for all
                    record types and outputs result to STDIO. Several strings 
                    may be set separated by |. If -rt set search only for this 
                    record types.
                    Example: -analyt "action|basic_call_state_model"
  -version          Output version information.
  -usage|help|?     Output this help.
END
    print $usage;
    exit(0);
}
