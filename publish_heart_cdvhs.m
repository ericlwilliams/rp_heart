% Define the structure, options_doc_nocode, 
% to exclude code from the output 
% and publish to Microsoft Word format:
clc
clear all
t=cputime;
options_html_nocode.format='html'
options_html_nocode.showCode=false

% Publish plot_all_cdvh.m:
publish('heart_cdvhs.m',options_html_nocode);
close all;
% View the published output file in Microsoft Word:
web('file:///G:/My Documents/studies/heart/html/heart_cdvhs.html');
e=cputime-t;
clear all;
