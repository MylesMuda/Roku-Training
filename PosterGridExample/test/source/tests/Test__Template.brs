' This is a Template, to be used when defining future TestSuite(s), make sure this is
' omitted from the Runner.setFunctions() call in main.
'
' Functions in this file:
'
'     TestSuite__Template
'     TemplateTestSuite_setUp
'     TemplateTestSuite_tearDown
'     TestCase__sampleTestCase
'     TestCase__sampleTestCase_setUp
'     TestCase__sampleTestCase_tearDown

'----------------------------------------------------------------
' Suite setup function.
'
' @returns a configured TestSuite object.
'----------------------------------------------------------------
function TestSuite__Template() as Object

    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()

    ' Test suite name for log statistics
    this.name = "TemplateTestSuite"

    this.setUp = TemplateTestSuite__setUp
    this.tearDown = TemplateTestSuite__tearDown

    ' Add tests to suite's tests collection.
    ' If no setup or tear down is needed on a per case basis, remove the parameters below.
    this.addTest("sampleTestCase", TestCase__sampleTestCase, TestCase__sampleTestCase_setUp, TestCase__sampleTestCase_tearDown)

    return this
end function

'----------------------------------------------------------------
' Suite level setup function.
' Executes before all tests within this suite.
'----------------------------------------------------------------
sub TemplateTestSuite__setUp()
    ' Makes use of the ItemGenerator for creating dummy data.
    scheme = {
        key1  : "integer"
        key2  : "string"
        key3  : "boolean"
    }
    m.testData = ItemGenerator(scheme)
end sub

'----------------------------------------------------------------
' Suite level tear down function.
' Executes after all tests within this suite.
'----------------------------------------------------------------
sub TemplateTestSuite__tearDown()
    m.delete("testData")
end sub

'----------------------------------------------------------------
' Sample test case.
'----------------------------------------------------------------
function TestCase__sampleTestCase()
    ' Need to access case level variables via testInstance.
    sampleTestVariable = m.testInstance.sampleTestVariable
    return m.assertEqual(sampleTestVariable, true)
end function

'----------------------------------------------------------------
' Sample test case specific setup.
' Executes before the sample test case.
'----------------------------------------------------------------
function TestCase__sampleTestCase_setUp()
    ' Note suite level variables are out of scope.
    ? "TestCase__sampleTestCase_setUp"
    m.sampleTestVariable = true
end function

'----------------------------------------------------------------
' Sample test case specific tear down.
' Executes after the sample test case.
'----------------------------------------------------------------
function TestCase__sampleTestCase_tearDown()
    ' Note suite level variables are out of scope.
    ? "TestCase__sampleTestCase_tearDown"
end function
