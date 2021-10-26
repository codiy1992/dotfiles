# Debug golang program on Spacemacs

* install latest stable nodejs
* [install gopls](https://github.com/golang/tools/blob/master/gopls/doc/emacs.md)
* Install the delve command by following instructions on [delve - installation](https://github.com/go-delve/delve/tree/master/Documentation/installation).
* in `.spacemacs` (open **lsp**, **dap**, **go** layer)

  ```lisp
  dotspacemacs-configuration-layers
   '((go :variables go-tab-width 4
                    go-backend 'lsp)
     (lsp :variables
          lsp-navigation 'peek)
     dap
   )
  ```

* in `.spacemacs.env` (make sure that **gopls** and **dlv** are installed and executable path exists in spacemacs environment variable)

  ```shell
  GO111MODULE=on
  PATH=/Users/codiy/go/bin
  ```

* in your **project root folder**(where **go.mod** is) add new file `emacs-debug.el`

```lisp
;; Eval Buffer with `M-x eval-buffer' to register the newly created template.

(dap-register-debug-template
  "your-template-name"
  (list :type "go"
        :request "launch"
        :name "your-template-name"
        :mode "auto"
        :program "xxxxxxxxx"
        :buildFlags nil
        :args nil
        :env nil
        :envFile nil))
```

* Start debuging
  * open **emacs-debug.el**.
  * Eval buffer.
  * Go to your program and place some breakpoints.
  * Then do M-x dap-debug and select xxxx.

* References
  * <https://github.com/emacs-lsp/dap-mode/issues/188>
  * <https://qiita.com/hjmkawano/items/e08aa163edc6631ff17e>
  * <https://github.com/golang/tools/blob/master/gopls/doc/emacs.md>
  * <https://emacs-lsp.github.io/dap-mode/page/configuration/#go>
