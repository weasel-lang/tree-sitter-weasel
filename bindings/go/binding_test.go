package tree_sitter_weasel_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_weasel "github.com/weasel-lang/tree-sitter-weasel/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_weasel.Language())
	if language == nil {
		t.Errorf("Error loading Weasel grammar")
	}
}
