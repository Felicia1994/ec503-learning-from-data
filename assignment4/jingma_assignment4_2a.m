% jingma
% 02/26/2018

% load files
train_data = load('./train.data');
test_data = load('./test.data');
train_label = load('./train.label');
test_label = load('./test.label');
vocabulary = textread('./vocabulary.txt','%s');
%
unique_train = length(unique(train_data(:,2)));
unique_test = length(unique(test_data(:,2)));
unique_entire = length(unique([train_data(:,2);test_data(:,2)]));
%
length_train = zeros(length(train_label),1); % the length of each document in training set
for i = 1:length(train_label)
    length_train(i,1) = sum(train_data(train_data(:,1)==i,3));
end
length_test = zeros(length(test_label),1); % the length of each document in test set
for i = 1:length(test_label)
    length_test(i,1) = sum(test_data(test_data(:,1)==i,3));
end
avg_train = mean(length_train);
std_train = std(length_train);
avg_test = mean(length_test);
std_test = std(length_test);
%
unique_test_only = unique_entire - unique_train;
%
words = zeros(unique_entire,1); % the number of appearances of each word
for i = 1:unique_entire
    words(i,1) = sum(train_data(train_data(:,2)==i,3)) + sum(test_data(test_data(:,2)==i,3));
end
[most_freq_number,most_freq_id] = maxk(words,10);
most_freq_words = vocabulary(most_freq_id);
%
least_freq_number = min(words);
least_freq_words_number = sum(words==least_freq_number);
least_freq_words = vocabulary(words==least_freq_number);
least_freq_words_od = least_freq_words(startsWith(least_freq_words,'od'));
