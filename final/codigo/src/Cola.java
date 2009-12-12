import java.util.ArrayList;


public class Cola<Type> {
  private ArrayList<Type> elements = null;

  public Cola() {
    this.elements = new ArrayList<Type>();
  }

  public void add(Type element) throws Exception{
    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }
    if(element == null){
      throw new Exception("Object can not be added");
    }

    elements.add(elements.size(), element);
  }

  public Type remove() throws Exception{
    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }

    if(elements.size() <= 0){
      return null;
    }

    return elements.remove(0);    
  }

  public Type swap(Type element) throws Exception{
    Type aux = null;

    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }
    if(element == null){
      throw new Exception("Object can not be added");
    }

    if(elements.size() <= 0){
      elements.add(0, element);
      aux = element;
    }
    else{
      aux = elements.remove(0);
      elements.add(0, element);
      elements.add(0, aux);
    }
    return aux;
  }
  
  public int size(){
    return elements.size();
  }
  
}
