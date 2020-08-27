#!/bin/bash

#################################
#
#  Marlesson Santana
#
#################################

EXP=${1:-5}

# Geral Default PARAMS

num_episodes=7
epochs=250 
obs_batch_size=1000
batch_size=200 
learning_rate=0.001 


## Fixed Popularity

mars-gym run interaction \
--project trivago.config.fixed_trivago_experiment \
--recommender-module-class trivago.model.FixedPolicyEstimator \
--recommender-extra-params '{}' \
--bandit-policy-class mars_gym.model.bandit.FixedPolicy \
--bandit-policy-params '{"arg": 2}' \
--data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
--learning-rate $learning_rate \
--optimizer adam \
--batch-size 200 \
--epochs $epochs \
--num-episodes $num_episodes \
--val-split-type random \
--obs-batch-size $obs_batch_size \
--observation "Popular Item" \
--full-refit 

# mars-gym evaluate interaction --model-task-id InteractionTraining____mars_gym_model_b___arg___2__9cb6645207  --direct-estimator-extra-params '{"recommender_module_class": "trivago.model.FixedPolicyEstimator"}' --offpolicy 

# Random

mars-gym run interaction \
--project trivago.config.fixed_trivago_experiment \
--recommender-module-class trivago.model.FixedPolicyEstimator \
--recommender-extra-params '{}' \
--bandit-policy-class mars_gym.model.bandit.RandomPolicy \
--data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
--learning-rate $learning_rate \
--optimizer adam \
--batch-size 200 \
--epochs $epochs \
--num-episodes $num_episodes \
--val-split-type random \
--obs-batch-size $obs_batch_size \
--full-refit 

# mars-gym evaluate interaction --model-task-id InteractionTraining____mars_gym_model_b____8af54d3fa2  --direct-estimator-extra-params '{"recommender_module_class": "trivago.model.FixedPolicyEstimator"}' --offpolicy 


for i in $(seq 1 $EXP) 
do
  # Egreedy

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.EpsilonGreedy \
  --bandit-policy-params '{"epsilon": 0.1}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

# mars-gym evaluate interaction --model-task-id InteractionTraining____mars_gym_model_b___epsilon___0_1__7e010580a9 --offpolicy 

  # LinUcb

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.LinUCB \
  --bandit-policy-params '{"alpha": 1e-5}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

  # custom_lin_ucb

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.CustomRewardModelLinUCB \
  --bandit-policy-params '{"alpha": 1e-5}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

  # Lin_ts

  # mars-gym run interaction \
  # --project trivago.config.trivago_experiment \
  # --recommender-module-class trivago.model.SimpleLinearModel \
  # --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  # --bandit-policy-class mars_gym.model.bandit.LinThompsonSampling \
  # --bandit-policy-params '{"v_sq": 0.1}' \
  # --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  # --learning-rate $learning_rate \
  # --optimizer adam \
  # --batch-size 200 \
  # --epochs $epochs \
  # --num-episodes $num_episodes \
  # --val-split-type random \
  # --obs-batch-size $obs_batch_size \
  # --full-refit --seed $i  


  # Adaptive

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.AdaptiveGreedy \
  --bandit-policy-params '{"exploration_threshold": 0.7, "decay_rate": 0.0000972907743983833}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

  # Percentil Adaptive

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.PercentileAdaptiveGreedy \
  --bandit-policy-params '{"exploration_threshold": 0.7}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

  ## softmax_explorer

  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.SoftmaxExplorer \
  --bandit-policy-params '{"logit_multiplier": 5.0}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  


  ## Explore the Exploit


  mars-gym run interaction \
  --project trivago.config.trivago_experiment \
  --recommender-module-class trivago.model.SimpleLinearModel \
  --recommender-extra-params '{"n_factors": 50, "metadata_size": 147, "window_hist_size": 10, "vocab_size": 120}' \
  --bandit-policy-class mars_gym.model.bandit.ExploreThenExploit \
  --bandit-policy-params '{"explore_rounds": 1000, "decay_rate": 0.0001872157}' \
  --data-frames-preparation-extra-params '{"filter_city": "Chicago, USA", "window_hist":10}' \
  --learning-rate $learning_rate \
  --optimizer adam \
  --batch-size 200 \
  --epochs $epochs \
  --num-episodes $num_episodes \
  --val-split-type random \
  --obs-batch-size $obs_batch_size \
  --full-refit --seed $i  

done
