/*                                                                       
 * Copyright (c) 2003 Century Software, Inc.   All Rights Reserved.     
 *                                                                       
 * This file is part of the PIXIL Operating Environment                 
 *                                                                       
 * The use, copying and distribution of this file is governed by one    
 * of two licenses, the PIXIL Commercial License, or the GNU General    
 * Public License, version 2.                                           
 *                                                                       
 * Licensees holding a valid PIXIL Commercial License may use this file 
 * in accordance with the PIXIL Commercial License Agreement provided   
 * with the Software. Others are governed under the terms of the GNU   
 * General Public License version 2.                                    
 *                                                                       
 * This file may be distributed and/or modified under the terms of the  
 * GNU General Public License version 2 as published by the Free        
 * Software Foundation and appearing in the file LICENSE.GPL included   
 * in the packaging of this file.                                      
 *                                                                       
 * This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING  
 * THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A            
 * PARTICULAR PURPOSE.                                                  
 *                                                                       
 * RESTRICTED RIGHTS LEGEND                                             
 *                                                                     
 * Use, duplication, or disclosure by the government is subject to      
 * restriction as set forth in paragraph (b)(3)(b) of the Rights in     
 * Technical Data and Computer Software clause in DAR 7-104.9(a).       
 *                                                                      
 * See http://www.pixil.org/gpl/ for GPL licensing       
 * information.                                                         
 *                                                                      
 * See http://www.pixil.org/license.html or              
 * email cetsales@centurysoftware.com for information about the PIXIL   
 * Commercial License Agreement, or if any conditions of this licensing 
 * are not clear to you.                                                
 */

//--------------------------------------------------------------//
// Custom field name database.                                  //
//--------------------------------------------------------------//
#ifndef CUSTOMFIELDDB_H_

#define CUSTOMFIELDDB_H_

#ifdef WIN32
#pragma warning(disable:4786)
#define inline __inline
#endif /*  */

#include "config.h"
#include "NxDbAccess.h"

// Field References
#define CUSTOMID 0
#define CUSTOM 1

#define CUSTOM_NAME 10
class CustomFieldDB:public NxDbAccess
{
  public:CustomFieldDB();	// Constructor
    ~CustomFieldDB();		// Destructor
    inline string GetName(int nRow) const	// Get the custom field name
    {
	return (GetStringValue(nRow, CUSTOM));
    }
    static CustomFieldDB *GetCustomField();	// Get the singleton pointer
    inline int GetCustomID(int nRow) const	// Get the recno column
    {
	return (GetIntValue(nRow, CUSTOMID));
    }
    int Insert(int nID);	// Insert a row and set its key id
    inline void SetName(int nRow,	// Set the custom field name
			const char *pszName)
    {
	SetColumn(nRow, CUSTOM, pszName);
    }
  private:static const char *m_pszDefaultName[];
    // Initial database values
    static CustomFieldDB *m_pThis;	// Singleton pointer
    void Init();		// Initialize the database if empty
};


#endif /*  */
