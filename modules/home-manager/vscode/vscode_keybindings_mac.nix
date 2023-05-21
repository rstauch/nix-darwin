[
  {
    key = "cmd+=";
    command = "editor.action.commentLine";
    when = "editorTextFocus && !editorReadonly";
  }
  {
    key = "cmd+o";
    command = "editor.action.formatDocument";
    when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
  }
  {
    key = "cmd+l";
    command = "editor.action.formatDocument";
    when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
  }
  {
    key = "cmd+w";
    command = "editor.action.toggleWordWrap";
  }
  {
    key = "ctrl+d";
    command = "editor.action.duplicateSelection";
  }

  # tut nicht
  # { key = "cmd+#"; command = "workbench.action.moveEditorToRightGroup"; }
  {
    key = "cmd+h";
    command = "workbench.action.moveEditorToRightGroup";
  }

  {
    key = "cmd+up";
    command = "workbench.action.focusAboveGroup";
  }
  {
    key = "cmd+down";
    command = "workbench.action.focusBelowGroup";
  }
  {
    key = "cmd+left";
    command = "workbench.action.focusLeftGroup";
  }
  {
    key = "cmd+right";
    command = "workbench.action.focusRightGroup";
  }

  {
    key = "cmd+e";
    command = "workbench.action.openRecent";
  }

  {
    key = "cmd+f";
    command = "workbench.action.findInFiles";
  }
  {
    key = "cmd+f";
    command = "-workbench.action.findInFiles";
  }
  {
    key = "cmd+f";
    command = "workbench.action.toggleSidebarVisibility";
    when = "searchViewletVisible";
  }
  {
    key = "cmd+f";
    command = "-workbench.action.toggleSidebarVisibility";
    when = "searchViewletVisible";
  }

  {
    key = "cmd+1";
    command = "workbench.view.explorer";
  }
  {
    key = "cmd+1";
    command = "-workbench.view.explorer";
  }
  {
    key = "cmd+1";
    command = "workbench.action.toggleSidebarVisibility";
    when = "explorerViewletVisible";
  }
  {
    key = "cmd+1";
    command = "-workbench.action.toggleSidebarVisibility";
    when = "explorerViewletVisible";
  }

  {
    key = "ctrl+r";
    command = "editor.action.startFindReplaceAction";
    when = "editorFocus || editorIsOpen";
  }

  {
    key = "ctrl+f";
    command = "editor.action.nextMatchFindAction";
    when = "editorFocus || editorIsOpen";
  }
]
