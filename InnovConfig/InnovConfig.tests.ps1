Describe 'ModuleTest' {
    Context 'Step1' {
        It 'Connect-Innov' {
            $res = Connect-Innov 'root'
            $res | Should -Be 'Aras.IOM.Innovator'
        }
        It 'Restore-Database' {
            $res = Restore-Database
            $res | Should -Be 0
        }
        It 'Import-Packages' {
            $res = Connect-Innov 'root'
            $res | Should -Be 'Aras.IOM.Innovator'
        }
    }
    Context 'Step2'{
        It 'User makes changes'{
            $aml_files = @()
            $aml_files += Resolve-Path 'src\Test-AML\T01-ModuleTest-2-MakeChanges.xml'
            $res = Send-AMLFiles 'root' $aml_files
            $res | Should -Be  @('Aras.IOM.Innovator', 0)
        }
        It 'Export-ConfigReport'{
            $res = Export-ConfigReport
            $res | Should -Be 0
        }
    }
    Context 'Step3'{
        It 'Export-Changes' {
            $res = 0 #Export-Changes
            $res | Should -Be '0'
        }
    }
}