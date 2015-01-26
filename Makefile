# Makefile
# Install dotfiles using `make` command
#
# Copyright (c) 2014  Stijn Wouters <w.stijn@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Last modified: 26 January 2015.
# By: Stijn Wouters.
.PHONY: all bash conky editorconfig fish git terminator todo vim


DOTFILES	:= ${PWD}/dotfiles
TARGET		:= ${HOME}
LINK		:= ln -bs

BASH		:= $(shell which bash)
BASH_PROFILE:= ${DOTFILES}/bash_profile
BASHRC		:= ${DOTFILES}/bashrc

EDITORCFG	:= ${DOTFILES}/editorconfig

FISH		:= $(shell which fish)
FISHCONFIG	:= ${DOTFILES}/config/fish/config.fish
FISHVIRTUAL	:= ${DOTFILES}/config/fish/virtual.fish
FISH_PROMPT	:= ${DOTFILES}/config/fish/functions/fish_prompt.fish

GIT			:= $(shell which git)
GITIGNORE	:= ${DOTFILES}/config/git/ignore
GITCONFIG	:= ${DOTFILES}/gitconfig

TODO		:= $(shell which todo)
TODOCONFIG	:= ${DOTFILES}/todo/config

TERMINATOR	:= $(shell which terminator)
TERMCFG		:= ${DOTFILES}/config/terminator/config

VIM			:= $(shell which vim)
VIMRC		:= ${DOTFILES}/vimrc
VUNDLE		:= ${TARGET}/.vim/bundle/Vundle.vim


all: bash conky fish git terminator todo vim


bash: ${BASH_PROFILE} ${BASHRC}
ifdef BASH
	${LINK} ${BASH_PROFILE} ${TARGET}/.bash_profile
	${LINK} ${BASHRC} ${TARGET}/.bashrc
endif


editorconfig: ${EDITORCFG}
	${LINK} ${EDITORCFG} ${TARGET}/.editorconfig


fish: ${FISHCONFIG} ${FISH_PROMPT}
ifdef FISH
	mkdir -p ${TARGET}/.config/fish/functions/
	${LINK} ${FISHCONFIG} ${TARGET}/.config/fish/config.fish
	${LINK} ${FISHVIRTUAL} ${TARGET}/.config/fish/virtual.fish
	${LINK} ${FISH_PROMPT} ${TARGET}/.config/fish/functions/fish_prompt.fish
endif


git: ${GITIGNORE}
ifdef GIT
	mkdir -p ${TARGET}/.config/git/
	${LINK} ${GITCONFIG} ${TARGET}/.gitconfig
	${LINK} ${GITIGNORE} ${TARGET}/.config/git/ignore
endif


terminator: ${TERMCFG}
ifdef TERMINATOR
	mkdir -p ${TARGET}/.config/terminator/
	${LINK} ${TERMCFG} ${TARGET}/.config/terminator/config
endif


todo: ${TODOCONFIG}
ifdef TODO
	mkdir -p ${TARGET}/.todo/
	${LINK} ${TODOCONFIG} ${TARGET}/.todo/config
endif


vim: ${VIMRC}
ifdef VIM
	mkdir -p ${TARGET}/.vim/bundle/
	[ -d ${VUNDLE} ] || git clone 'https://github.com/gmarik/Vundle.vim.git' ${VUNDLE}
	${LINK} ${VIMRC} ${TARGET}/.vimrc
endif
