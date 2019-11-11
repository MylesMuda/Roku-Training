sub main(args as Dynamic)
    if args.runTests = "true" and type(testRunner) = "Function" then
        runner = testRunner()
    
        runner.setFunctions([
            TestSuite__Template
        ])
  
        runner.logger.setVerbosity(3)
        runner.setFailFast(true)
        
        runner.run()
    end if
end sub