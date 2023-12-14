# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
pin "axios", to: "https://cdn.skypack.dev/axios@1.6.2"
pin "#lib/adapters/http.js", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/@empty.js"
pin "#lib/platform/node/classes/FormData.js", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/@empty.js"
pin "#lib/platform/node/index.js", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/@empty.js"
pin "geolib", to: "https://ga.jspm.io/npm:geolib@3.3.4/es/index.js"
pin "lodash-es", to: "https://ga.jspm.io/npm:lodash-es@4.17.21/lodash.js"
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js"
pin "stimulus-flatpickr", to: "https://ga.jspm.io/npm:stimulus-flatpickr@3.0.0-0/dist/index.m.js"
