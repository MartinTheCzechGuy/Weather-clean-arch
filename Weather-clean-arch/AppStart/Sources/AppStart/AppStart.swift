import CitySearch
import CitySearcher
import InstanceProvider
import Swinject

public struct AppStart {
    
    private var assemblies: [Assembly] = [
        CitySearchAssembly(),
        CitySearcherAssembly(),
        InstanceProviderAssembly()
    ]
    
    public init() {}
    
    func startApp<Instance>() -> Instance {
        let assembler = Assembler()
        assembler.apply(assemblies: assemblies)
        
        return assembler.resolver.resolve(Instance.self)!
    }
}
