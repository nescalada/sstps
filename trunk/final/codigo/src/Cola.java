import java.util.ArrayList;


public class Cola {
  private ArrayList<Object> elements = null;

  public Cola() {
    this.elements = new ArrayList<Object>();
  }

  public void add(Object element) throws Exception{
    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }
    if(element == null){
      throw new Exception("Object can not be added");
    }

    elements.add(elements.size()+1, element);
  }

  public Object remove() throws Exception{
    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }

    if(elements.size() <= 0){
      return null;
    }

    return elements.remove(0);    
  }

  public Object swap(Object element) throws Exception{
    Object aux = null;

    if(elements == null){
      throw new Exception("Object Cola not initialized");
    }
    if(element == null){
      throw new Exception("Object can not be added");
    }

    if(elements.size() <= 0){
      aux = element;
    }
    else{
      aux = elements.remove(0);
    }

    elements.add(0, element);
    return aux;
  }
}
