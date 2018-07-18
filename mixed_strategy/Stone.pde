enum FixStatus { unfixed, fixedMine, fixedEnemy };

class Stone
{
  int c;
  boolean isFixed;
  FixStatus status[];
  Stone adj[];
  
  Stone()
  {
    status = new FixStatus[8];
    adj = new Stone[8];
    
    for(int i=0; i<8; i++)
      status[i] = FixStatus.unfixed;
  }
  
  void setAdjacentStone(Stone a, int direction)
  {
    adj[direction] = a;
  }

// returns true if updated
  boolean updateDirectionStatus(int direction)
  {
    FixStatus org = status[direction];
    if( c == AKI )
      return false;
    
    if( adj[direction].c == SOTO )
      status[direction] = FixStatus.fixedMine;
    else if( adj[direction].c == -c )
    {
      if ( adj[direction].isFixed )
        status[direction] = FixStatus.fixedEnemy;
//      else if( !adj[direction].checkSpaceExists(direction) )
//        status[direction] = FixStatus.fixedEnemy;
      else
        status[direction] = FixStatus.unfixed;
    }
    else if( adj[direction].c == c )
      if( adj[direction].isFixed )
        status[direction] = FixStatus.fixedMine;
      else if( adj[direction].checkIfFixedEnemy(direction) )
        status[direction] = FixStatus.fixedEnemy;
//      else if(!adj[direction].checkSpaceExists(direction))
//        status[direction] = FixStatus.fixedEnemy;
      else
        status[direction] = FixStatus.unfixed;
    else
      status[direction] = FixStatus.unfixed;

    return( org != status[direction] );
  }     
  
  boolean checkIfFixedEnemy(int direction)
  {
    if( adj[direction].c == -c && adj[direction].isFixed )
      return(true);
    else if(adj[direction].c == c)
      return( adj[direction].checkIfFixedEnemy(direction) );
    else
      return(false);
  }
  
  boolean checkSpaceExists(int direction)
  {
    if( c == AKI )
      return true;
    if( c == SOTO )
      return false;
    return adj[direction].checkSpaceExists(direction);
  }
    
  
  boolean updateFixed()
  {
    boolean result = false;
    
    for(int i=0; i<8; i++)
      result = result || updateDirectionStatus(i);
    
    boolean tempFixed = true;
    for(int i=0; i<4; i++)
    {
      if( status[i] == FixStatus.fixedMine || status[i+4] == FixStatus.fixedMine || (status[i] == FixStatus.fixedEnemy && status[i+4] == FixStatus.fixedEnemy))
        continue;
      tempFixed = false;
      break;
    }
    
    isFixed = tempFixed;
    return result;
  }
}
