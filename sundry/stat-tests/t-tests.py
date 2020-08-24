#!/usr/bin/env python3
"""
T-tests to check for SNRs under different conditions.
Also does a levene test first to check that variances are the same.

File: t-tests.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


from scipy.stats import ttest_ind
from scipy.stats import levene
from scipy.stats import shapiro
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)


# No deaff
snrs_5_nodeaff = [
    3.76121142323672, 3.66275299194438, 3.22131784714772,
    3.82351057266779, 3.74621054039312
]
print("snrs_5_nodeaff: normality test: {}".format(
    shapiro(snrs_5_nodeaff)))

snrs_10_nodeaff = [
    3.3397585036499, 3.24382598035101, 3.3680609756314,
    3.77972010326976, 3.50059453696355
]
print("snrs_10_nodeaff: normality test: {}".format(
    shapiro(snrs_10_nodeaff)))

snrs_20_nodeaff = [
    3.42551905985876, 3.46811344026436, 3.34414078433102,
    3.71527869097569, 3.29100465605305
]
print("snrs_20_nodeaff: normality test: {}".format(
    shapiro(snrs_20_nodeaff)))

snrs_30_nodeaff = [
    3.50405777432877, 2.80377664912174, 2.90199035506626,
    3.74806863897793, 3.46215725804245
]
print("snrs_30_nodeaff: normality test: {}".format(
    shapiro(snrs_30_nodeaff)))


# No repair
snrs_5_deaff_no_repair = [
    3.49644563241269, 3.33836554549113, 3.45694649550282, 3.3099039124749,
    3.83848861822574
]
print("snrs_5_deaff_no_repair: normality test: {}".format(
    shapiro(snrs_5_deaff_no_repair)))

snrs_10_deaff_no_repair = [
    2.58110157278056, 2.96407736595606, 2.99735622622252, 2.79261356024605,
    3.34874971102434
]
print("snrs_10_deaff_no_repair: normality test: {}".format(
    shapiro(snrs_10_deaff_no_repair)))

snrs_20_deaff_no_repair = [
    2.06668565520519, 1.97088458401353, 2.24820198814575, 2.00579548598511,
    2.21457257585041
]
print("snrs_20_deaff_no_repair: normality test: {}".format(
    shapiro(snrs_20_deaff_no_repair)))

snrs_30_deaff_no_repair = [
    1.31569526473752, 1.41378633202214, 1.48412066095677, 1.83430156155502,
    1.74716548318854
]
print("snrs_30_deaff_no_repair: normality test: {}".format(
    shapiro(snrs_30_deaff_no_repair)))


# At the end of repair
snrs_5_repair = [
    1.53971051878526, 1.72200528055947, 1.76155767546236, 1.51734481043258,
    1.6757248966186
]
print("snrs_5_repair: normality test: {}".format(
    shapiro(snrs_5_repair)))

snrs_30_repair = [
    0.985427006208867, 1.25475386714798, 1.01142333488983, 0.771243346623021
]
print("snrs_30_repair: normality test: {}".format(
    shapiro(snrs_30_repair)))


print()
# SNRs for 5, 30 overlap without deaff
print("5, 30 no deafferentation")
levene_t, levene_p = levene(snrs_5_nodeaff, snrs_30_nodeaff)
print("levene-test: {}, {}".format(levene_t, levene_p))
# 0.33468400912094853 > 0.05: cannot reject null hypothesis of equal variances
t_t, t_p = ttest_ind(snrs_5_nodeaff, snrs_30_nodeaff)
print("t-test: {}, {}".format(t_t, t_p))
print()

# SNR after deaff but without repair
print("5 deafferentation vs no deafferentation")
levene_t, levene_p = levene(snrs_5_nodeaff, snrs_5_deaff_no_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_5_nodeaff, snrs_5_deaff_no_repair)
print("t-test: {}, {}".format(t_t, t_p))
print()

print("10 deafferentation vs no deafferentation")
levene_t, levene_p = levene(snrs_10_nodeaff, snrs_10_deaff_no_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_10_nodeaff, snrs_10_deaff_no_repair)
print("t-test: {}, {}".format(t_t, t_p))
print()

print("20 deafferentation vs no deafferentation")
levene_t, levene_p = levene(snrs_20_nodeaff, snrs_20_deaff_no_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_20_nodeaff, snrs_20_deaff_no_repair)
print("t-test: {}, {}".format(t_t, t_p))
print()

print("30 deafferentation vs no deafferentation")
levene_t, levene_p = levene(snrs_30_nodeaff, snrs_30_deaff_no_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_30_nodeaff, snrs_30_deaff_no_repair)
print("t-test: {}, {}".format(t_t, t_p))
print()

# No deaff, and after repair
print("5 normal vs after repair")
levene_t, levene_p = levene(snrs_5_nodeaff, snrs_5_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_5_nodeaff, snrs_5_repair)
print("t-test: {}, {}".format(t_t, t_p))
print()

print("30 normal vs after repair")
levene_t, levene_p = levene(snrs_30_nodeaff, snrs_30_repair)
print("levene-test: {}, {}".format(levene_t, levene_p))
t_t, t_p = ttest_ind(snrs_30_nodeaff, snrs_30_repair)
print("t-test: {}, {}".format(t_t, t_p))
